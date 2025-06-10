;; Documentation Management Contract
;; Manages logistics documentation and compliance

(define-constant ERR_DOC_NOT_FOUND (err u400))
(define-constant ERR_UNAUTHORIZED (err u401))
(define-constant ERR_INVALID_DOC_TYPE (err u402))

;; Document types
(define-constant DOC_TYPE_BILL_OF_LADING u1)
(define-constant DOC_TYPE_CUSTOMS u2)
(define-constant DOC_TYPE_INSURANCE u3)
(define-constant DOC_TYPE_MANIFEST u4)

;; Document storage
(define-map documents
  { doc-id: uint }
  {
    doc-type: uint,
    title: (string-ascii 100),
    hash: (string-ascii 64),
    created-by: principal,
    created-at: uint,
    route-id: (optional uint),
    transfer-id: (optional uint),
    status: uint
  }
)

(define-map document-access
  { doc-id: uint, accessor: principal }
  { granted-at: uint, permissions: uint }
)

(define-data-var next-doc-id uint u1)

;; Create document
(define-public (create-document (doc-type uint)
                              (title (string-ascii 100))
                              (hash (string-ascii 64))
                              (route-id (optional uint))
                              (transfer-id (optional uint)))
  (let ((doc-id (var-get next-doc-id)))
    (asserts! (<= doc-type u4) ERR_INVALID_DOC_TYPE)
    (map-set documents
      { doc-id: doc-id }
      {
        doc-type: doc-type,
        title: title,
        hash: hash,
        created-by: tx-sender,
        created-at: block-height,
        route-id: route-id,
        transfer-id: transfer-id,
        status: u1
      }
    )
    (var-set next-doc-id (+ doc-id u1))
    (ok doc-id)
  )
)

;; Grant document access
(define-public (grant-access (doc-id uint) (accessor principal) (permissions uint))
  (match (map-get? documents { doc-id: doc-id })
    doc-data
    (begin
      (asserts! (is-eq tx-sender (get created-by doc-data)) ERR_UNAUTHORIZED)
      (map-set document-access
        { doc-id: doc-id, accessor: accessor }
        { granted-at: block-height, permissions: permissions }
      )
      (ok true)
    )
    ERR_DOC_NOT_FOUND
  )
)

;; Get document
(define-read-only (get-document (doc-id uint))
  (map-get? documents { doc-id: doc-id })
)

;; Check document access
(define-read-only (has-access (doc-id uint) (accessor principal))
  (match (map-get? documents { doc-id: doc-id })
    doc-data
    (or
      (is-eq accessor (get created-by doc-data))
      (is-some (map-get? document-access { doc-id: doc-id, accessor: accessor }))
    )
    false
  )
)

;; Verify document integrity
(define-read-only (verify-document (doc-id uint) (provided-hash (string-ascii 64)))
  (match (map-get? documents { doc-id: doc-id })
    doc-data (is-eq (get hash doc-data) provided-hash)
    false
  )
)

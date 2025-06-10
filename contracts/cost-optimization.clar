;; Cost Optimization Contract
;; Optimizes costs for intermodal logistics operations

(define-constant ERR_INVALID_CALCULATION (err u500))
(define-constant ERR_ROUTE_NOT_FOUND (err u501))

;; Cost factors
(define-map cost-factors
  { factor-type: (string-ascii 20) }
  { multiplier: uint, base-cost: uint }
)

;; Route cost calculations
(define-map route-costs
  { route-id: uint }
  {
    base-cost: uint,
    fuel-cost: uint,
    labor-cost: uint,
    equipment-cost: uint,
    insurance-cost: uint,
    total-cost: uint,
    calculated-at: uint
  }
)

;; Initialize cost factors
(define-private (init-cost-factors)
  (begin
    (map-set cost-factors { factor-type: "fuel" } { multiplier: u120, base-cost: u100 })
    (map-set cost-factors { factor-type: "labor" } { multiplier: u110, base-cost: u200 })
    (map-set cost-factors { factor-type: "equipment" } { multiplier: u105, base-cost: u150 })
    (map-set cost-factors { factor-type: "insurance" } { multiplier: u102, base-cost: u50 })
  )
)

;; Calculate route cost
(define-public (calculate-route-cost (route-id uint)
                                   (distance uint)
                                   (duration uint)
                                   (cargo-weight uint))
  (let (
    (fuel-factor (default-to { multiplier: u120, base-cost: u100 }
                            (map-get? cost-factors { factor-type: "fuel" })))
    (labor-factor (default-to { multiplier: u110, base-cost: u200 }
                             (map-get? cost-factors { factor-type: "labor" })))
    (equipment-factor (default-to { multiplier: u105, base-cost: u150 }
                                 (map-get? cost-factors { factor-type: "equipment" })))
    (insurance-factor (default-to { multiplier: u102, base-cost: u50 }
                                 (map-get? cost-factors { factor-type: "insurance" })))
  )
  (let (
    (fuel-cost (* distance (get base-cost fuel-factor)))
    (labor-cost (* duration (get base-cost labor-factor)))
    (equipment-cost (* cargo-weight (get base-cost equipment-factor)))
    (insurance-cost (* cargo-weight (get base-cost insurance-factor)))
    (total-cost (+ fuel-cost (+ labor-cost (+ equipment-cost insurance-cost))))
  )
    (map-set route-costs
      { route-id: route-id }
      {
        base-cost: (* distance u10),
        fuel-cost: fuel-cost,
        labor-cost: labor-cost,
        equipment-cost: equipment-cost,
        insurance-cost: insurance-cost,
        total-cost: total-cost,
        calculated-at: block-height
      }
    )
    (ok total-cost)
  ))
)

;; Update cost factor
(define-public (update-cost-factor (factor-type (string-ascii 20))
                                 (multiplier uint)
                                 (base-cost uint))
  (begin
    (map-set cost-factors
      { factor-type: factor-type }
      { multiplier: multiplier, base-cost: base-cost }
    )
    (ok true)
  )
)

;; Get route cost breakdown
(define-read-only (get-route-cost (route-id uint))
  (map-get? route-costs { route-id: route-id })
)

;; Get cost factor
(define-read-only (get-cost-factor (factor-type (string-ascii 20)))
  (map-get? cost-factors { factor-type: factor-type })
)

;; Compare route costs
(define-read-only (compare-routes (route-id-1 uint) (route-id-2 uint))
  (match (map-get? route-costs { route-id: route-id-1 })
    cost-1
    (match (map-get? route-costs { route-id: route-id-2 })
      cost-2
      (some {
        route-1-cost: (get total-cost cost-1),
        route-2-cost: (get total-cost cost-2),
        cheaper-route: (if (< (get total-cost cost-1) (get total-cost cost-2)) route-id-1 route-id-2),
        savings: (if (< (get total-cost cost-1) (get total-cost cost-2))
                    (- (get total-cost cost-2) (get total-cost cost-1))
                    (- (get total-cost cost-1) (get total-cost cost-2)))
      })
      none
    )
    none
  )
)

;; Initialize the contract
(init-cost-factors)

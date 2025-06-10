# Decentralized Transportation Intermodal Logistics

A comprehensive blockchain-based logistics management system built on the Stacks blockchain using Clarity smart contracts. This system provides end-to-end management of intermodal transportation logistics with decentralized verification, optimization, and coordination.

## 🚀 Features

### Core Contracts

1. **Logistics Provider Verification** (`logistics-provider-verification.clar`)
    - Provider registration and verification
    - Capability management (transport modes, capacity, coverage areas)
    - Rating and status tracking
    - Decentralized provider validation

2. **Route Optimization** (`route-optimization.clar`)
    - Multi-modal route planning
    - Cost and time estimation
    - Route segmentation
    - Performance optimization

3. **Transfer Coordination** (`transfer-coordination.clar`)
    - Intermodal transfer scheduling
    - Real-time status tracking
    - Checkpoint management
    - Provider coordination

4. **Documentation Management** (`documentation-management.clar`)
    - Digital document storage and verification
    - Access control and permissions
    - Document integrity verification
    - Compliance management

5. **Cost Optimization** (`cost-optimization.clar`)
    - Dynamic cost calculation
    - Multi-factor cost analysis
    - Route cost comparison
    - Cost factor management

## 🏗️ Architecture

The system is built using a modular architecture with separate smart contracts for each major functionality:

\`\`\`
┌─────────────────────────────────────────────────────────────┐
│                    Frontend Application                     │
├─────────────────────────────────────────────────────────────┤
│                    Smart Contracts Layer                    │
├─────────────┬─────────────┬─────────────┬─────────────┬─────┤
│  Provider   │    Route    │  Transfer   │ Document    │Cost │
│Verification │Optimization │Coordination │ Management  │Opt. │
├─────────────┴─────────────┴─────────────┴─────────────┴─────┤
│                    Stacks Blockchain                        │
└─────────────────────────────────────────────────────────────┘
\`\`\`

## 🛠️ Installation

### Prerequisites

- Node.js (v16 or higher)
- Clarinet CLI
- Stacks Wallet

### Setup

1. Clone the repository:
   \`\`\`bash
   git clone https://github.com/your-org/decentralized-logistics
   cd decentralized-logistics
   \`\`\`

2. Install dependencies:
   \`\`\`bash
   npm install
   \`\`\`

3. Initialize Clarinet project:
   \`\`\`bash
   clarinet new logistics-system
   cd logistics-system
   \`\`\`

4. Copy contract files to the contracts directory

5. Run tests:
   \`\`\`bash
   npm test
   \`\`\`

## 📋 Usage

### Provider Registration

\`\`\`clarity
(contract-call? .logistics-provider-verification register-provider
"Global Logistics Inc"
"GL-2024-001"
(list "truck" "rail" "ship")
u50000
(list "North America" "Europe")
)
\`\`\`

### Route Creation

\`\`\`clarity
(contract-call? .route-optimization create-route
"New York"
"Los Angeles"
(list "truck" "rail")
u72
u5000
u2800
)
\`\`\`

### Transfer Scheduling

\`\`\`clarity
(contract-call? .transfer-coordination schedule-transfer
u1
'ST1SJ3DTE5DN7X54YDH5D64R3BCB6A2AG2ZQ8YPD5
'ST2CY5V39NHDPWSXMW9QDT3HC3GD6Q6XX4CFRK9AG
"Chicago Hub"
u1000
"Electronics shipment - 500 units"
)
\`\`\`

### Document Management

\`\`\`clarity
(contract-call? .documentation-management create-document
u1  ;; DOC_TYPE_BILL_OF_LADING
"Bill of Lading - Shipment #12345"
"a1b2c3d4e5f6..."
(some u1)
(some u1)
)
\`\`\`

### Cost Calculation

\`\`\`clarity
(contract-call? .cost-optimization calculate-route-cost
u1
u2800
u72
u10000
)
\`\`\`

## 🧪 Testing

The project includes comprehensive test suites for all contracts:

\`\`\`bash
# Run all tests
npm test

# Run specific test file
npm test -- tests/logistics-provider-verification.test.ts

# Run tests with coverage
npm run test:coverage
\`\`\`

### Test Coverage

- Provider verification and management
- Route optimization algorithms
- Transfer coordination workflows
- Document management and access control
- Cost calculation and optimization

## 🔧 Configuration

### Environment Variables

Create a \`.env\` file in the root directory:

\`\`\`env
STACKS_NETWORK=testnet
STACKS_API_URL=https://stacks-node-api.testnet.stacks.co
CONTRACT_DEPLOYER_KEY=your-private-key
\`\`\`

### Network Configuration

The contracts are configured for Stacks testnet by default. For mainnet deployment, update the network configuration in \`Clarinet.toml\`.

## 📊 Data Models

### Provider Data Structure
\`\`\`clarity
{
name: (string-ascii 100),
license-number: (string-ascii 50),
status: uint,
verification-date: uint,
rating: uint
}
\`\`\`

### Route Data Structure
\`\`\`clarity
{
origin: (string-ascii 50),
destination: (string-ascii 50),
transport-modes: (list 5 (string-ascii 20)),
estimated-time: uint,
estimated-cost: uint,
distance: uint,
created-by: principal,
status: uint
}
\`\`\`

## 🔐 Security Features

- **Access Control**: Role-based permissions for contract functions
- **Data Integrity**: Cryptographic hashing for document verification
- **Immutable Records**: Blockchain-based audit trail
- **Decentralized Verification**: Multi-party validation system

## 🚀 Deployment

### Testnet Deployment

\`\`\`bash
clarinet deploy --testnet
\`\`\`

### Mainnet Deployment

\`\`\`bash
clarinet deploy --mainnet
\`\`\`

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (\`git checkout -b feature/amazing-feature\`)
3. Commit your changes (\`git commit -m 'Add amazing feature'\`)
4. Push to the branch (\`git push origin feature/amazing-feature\`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🆘 Support

For support and questions:
- Create an issue on GitHub
- Join our Discord community
- Email: support@decentralized-logistics.com

## 🗺️ Roadmap

- [ ] Mobile application development
- [ ] IoT device integration
- [ ] AI-powered route optimization
- [ ] Cross-chain interoperability
- [ ] Advanced analytics dashboard
- [ ] API gateway implementation

## 📈 Metrics and Analytics

The system tracks key performance indicators:
- Route efficiency metrics
- Cost optimization savings
- Transfer success rates
- Provider performance ratings
- Document processing times

---

Built with ❤️ using Stacks and Clarity
\`\`\`
\`\`\`

Finally, let's create the PR details file:

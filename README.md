# Internal Wallet Transactional System (API)

by Abdul Salam (@abdulsalam01)

## Project Overview

This project is a Ruby on Rails-based API for managing wallets and transactions across various entities, such as users, teams, and stocks. The system allows for money transfers, deposits, and withdrawals between wallets while ensuring the integrity of transactions with proper validations and adherence to ACID standards.

### Key Features
- **Wallet Management**: Every entity (User, Team, Stock) has its own wallet.
- **Transaction Types**: Supports multiple transaction types: debit, credit, and transfer.
- **Session Management**: Custom session management for user authentication without external gems.
- **Stock Price Integration**: Integration with the [LatestStockPrice API](https://rapidapi.com/suneetk92/api/latest-stock-price) to fetch stock prices.
- **Balance Calculation**: Wallet balances are calculated by summing transaction records.
- **ACID Compliant**: Transactions adhere to ACID properties for data integrity.
- **Encryption**: Custom encryption library for securing sensitive data.
- **STI for Transactions**: Uses Single Table Inheritance (STI) to handle different transaction types.

## Requirements
- **Ruby version**: 3.3.5
- **Rails version**: 7.2.1
- **Database**: SQLite

## Tasks Implemented
1. Architected a generic wallet solution to handle money manipulation between entities (User, Team, Stock, etc.).
2. Created model relationships and validations to ensure proper wallet and transaction handling.
3. Implemented Single Table Inheritance (STI) for handling different transaction types (debit, credit, transfer).
4. Developed a custom sign-in (session management) solution.
5. Built the `LatestStockPrice` library to interact with the [LatestStockPrice API](https://rapidapi.com/suneetk92/api/latest-stock-price), providing price data via `price`, `prices`, and `price_all` endpoints.
6. Created migration and seeder files to set up the database.
7. Developed custom encryption and session management libraries.

## Models and Relationships
- **User, Team, Stock**: Entities with associated wallets.
- **Wallet**: Stores balances for different entities (User, Team, Stock).
- **Transaction**: Handles debit, credit, and transfer transactions, with validations to ensure data consistency.

## Endpoints

### 1. Generate User Token
Generates a token for a user based on their wallet ID.

**[GET]** `/user/generate?wallet_id={base_on_seeder}`  
Example: `/user/generate?wallet_id=1`

### 2. Get User Transactions
Fetches all transactions and the current balance for the logged-in user.

**[GET]** `/transaction`  
Requires `Authorization` header with the token obtained from `/user/generate`.

### 3. Make a Transaction
Creates a transaction between wallets (for user, team, or stock). Supports debit, credit, and transfer.

**[POST]** `/transaction`  
Payload Example:
```json
{
  "transaction": {
    "transaction_type": "debit|credit|transfer",
    "target_wallet_id": 1,  // required if type is transfer
    "amount": 10
  }
}
```

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/abdulsalam01/internal-wallet-api.git
   cd internal-wallet-api
   ```

2. Install dependencies:
   ```bash
   bundle install
   ```

3. Set up the database:
   ```bash
   rails db:migrate
   rails db:seed
   ```

4. Start the Rails server:
   ```bash
   rails s
   ```

## Libraries Used

- **Kaminari**: For pagination in API responses.
- **dotenv-rails**: For loading environment variables.
- **SQLite**: As the database for local development.

## Custom Libraries by Own

- **Encryption Library**: A custom-built encryption mechanism for securing sensitive data.
- **Session Management Library**: Custom session handling without external gems, ensuring flexibility and security.
- **LatestStockPrice Library**: A gem-style library placed in the `lib` folder for interacting with the LatestStockPrice API to fetch stock prices.

## Example Queries

### Generate User Token
```bash
curl -X GET "http://localhost:3000/user/generate?wallet_id=1"
```

### Get Transactions
```bash
curl -X GET "http://localhost:3000/transaction" -H "Authorization: Bearer <token>"
```

### Make a Transaction (Debit)
```bash
curl -X POST "http://localhost:3000/transaction" -H "Authorization: Bearer <token>" -d '{
  "transaction": {
    "transaction_type": "debit",
    "amount": 10
  }
}'
```

## Future Improvements
- Implement multi-currency support.
- Add notifications for successful or failed transactions.
- Expand session management to include multi-factor authentication (MFA).
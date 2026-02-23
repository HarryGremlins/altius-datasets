# Altius Datasets

This repository contains scripts to generate various transaction patterns for blockchain benchmarking.

## Directory Structure

The generated datasets are organized into the following categories:

- `transfer/many-to-many/`: Many-to-many transaction patterns
- `transfer/many-to-one/`: Many-to-one transaction patterns
- `transfer/one-to-many/`: One-to-many transaction patterns
- `transfer/chained/`: Chained transaction patterns
- `transfer/self-to-self/`: Self-to-self transaction patterns

## Dataset Types

### Many-to-Many (m2m)
- Transaction counts: 10, 100, 1k, 10k
- Conflict ratios: 0%, 10%, 20%, 50%, 80%
- Available in both native and ERC20 token versions

### Many-to-One (m2o)
- Transaction counts: 100, 1k, 10k
- Group sizes: 5, 20, 50 (for t100); 50, 200, 500 (for t1k); 500, 2000, 5000 (for t10k)
- Available in both native and ERC20 token versions

### One-to-Many (o2m)
- Transaction counts: 100, 1k, 10k
- Group sizes: 5, 20, 50 (for t100); 50, 200, 500 (for t1k); 500, 2000, 5000 (for t10k)
- Available in both native and ERC20 token versions

### Chained Transactions
- Transaction counts: 100, 1k, 10k
- Group sizes: 5, 20, 50 (for t100); 50, 200, 500 (for t1k); 500, 2000, 5000 (for t10k)
- Available in both native and ERC20 token versions

### Self-to-Self (s2s)
- Transaction counts: 10, 100, 1k, 10k
- Available in both native and ERC20 token versions

## Usage

To re-generate all datasets, run:

```bash
./scripts/generate_datasets.sh
./scripts/generate_m2o.sh
```

This will create the complete set of transaction patterns in the `transfer/` directory.

## File Naming Convention

Files follow this naming pattern:
- `{pattern}-{token}-t{tx}-{param}.json`

Where:
- `pattern`: Transaction pattern (m2m, m2o, o2m, chain, s2s)
- `token`: Optional "erc20" for ERC20 token transactions
- `tx`: Transaction count (10, 100, 1k, 10k)
- `param`: Additional parameters (c for conflict ratio, g for group size)

Example:
- `m2m-t10-c50.json`: Many-to-many pattern with 10 transactions and 50% conflict ratio
- `o2m-erc20-t1k-g200.json`: ERC20 one-to-many pattern with 1000 transactions and group size 200

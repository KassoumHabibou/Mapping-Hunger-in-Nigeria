# Mapping Hunger in Nigeria: A Data-Driven Approach using Machine Learning

## Project Overview
This repository contains the replication codes for a spatial machine learning analysis predicting child stunting rates across Nigerian Local Government Areas (LGAs). The project combines multiple national surveys (NDHS, MICS, and LSMS) with geospatial data to generate high-resolution predictions of stunting rates and evaluate the impact of nutrition interventions.

## Data Sources
- **Survey Data**:
  - Nigeria Demographic and Health Survey (NDHS)
  - Multiple Indicator Cluster Survey (MICS)
  - Living Standards Measurement Study (LSMS)
- **Geospatial Data**:
  - Survey cluster coordinates
  - Environmental covariates
  - Infrastructure and goephysical data

## Repository Structure
```
├── input/
│   ├── data/           # Original survey datasets
│   ├── paper/          # Papers and litterature
├── output/
│   ├── data/          # Cleaned datasets
│   ├── img/           # Spatial Images
├── paper/             # Papers

```

## Requirements
- Python 3.8+
- R 4.0+


## Installation
1. Clone this repository:
```bash
git clone https://github.com/KassoumHabibou/Mapping-Hunger-in-Nigeria.git
cd nigeria-stunting-prediction
```

2. Create a virtual environment:
```bash
python -m venv env
source env/bin/activate  # On Windows: env\Scripts\activate
```

3. Install dependencies:
```bash
pip install -r requirements.txt
```


## License
This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.

## Authors
- IBRAHIM KASSOUM Habibou
- HEMA Aboubacar

## Contact
For questions or feedback, please open an issue or contact [ibrahimkassoumhabibou@gmail.com].

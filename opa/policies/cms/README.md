# CMS (Column Masking Security) Package

The CMS package provides column masking operations for secure data handling. It consists of several Rego files that implement different column masking techniques, such as hash masking and star masking.

Column masking can be used for masking sensitive columns. Once defined the users that the mask applies to will have no way to access the original values(including using AS in their SQL query).

## Table of Contents

- [Installation](#installation)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Installation

To use the CMS package, you need to have [Trino](https://trino.io/) and [OPA (Open Policy Agent)](https://www.openpolicyagent.org/) installed. Follow the installation instructions for both Trino and OPA.

Once you have Trino and OPA set up, you can clone this repository and copy the `cms` package into your OPA policies directory.

## Usage

To use the CMS package, you need to load the relevant Rego files into OPA. The following Rego files are available in the `cms` package:

- `mask.rego`: Implements the main logic for navigating between different use cases and files.
- `hash_masking.rego`: Implements hash masking for column values.
- `star_masking.rego`: Implements star masking for column values.

The different mask types are relevent to different cenarios. If you do not need to use the values that you want to mask, you can use the star masking to simply replace all the column's values with a placeholder. If you need also to use the column values, while not giving access to their original value, you can use the hash mask to create a unique hash for the column values.

Mask Type | Star | Hash 
--- | --- | --- 
Original value should be blocked | $${color{green}V}$$	 | $${color{green}V}$$	
The masked values need to differentiated between  | $${color{red}X}$$ | $${color{green}V}$$ 
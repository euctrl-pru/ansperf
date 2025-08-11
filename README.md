# ansperf
Workspace for the development of a GANP/PBWG/BRA-EUR/CHN-EUR informed package.

The general objective of air navigation services is to enable the "... safe, efficient, and orderly flow of air traffic."
ICAO promotes further the use of a performance-based approach and encourages stakeholder to monitor and benchmark services.
For this purpose a set of (global) key performance indicators (KPI) were established under the Global Air Navigation Plan. 
These KPIs (and variants of them) are actively used by the performance benchmarking community.

This package is jointly developed by the Department of Airspace Control (DECEA) und EUROCONTROL.
Performance groups of both organisations are committed to further harmonise the use of the KPIs as part of the bi-lateral and multi-lateral/international work.

The `{ansperf}` package implements the common KPIs and supporting metrics in `R`.

## GANP KPIs

The `performance framework` of the GANP lists the following KPIs (c.f. https://www4.icao.int/ganpportal/ASBU/KPI) and whether `{ansperf}` has it implemented:

```{r, echo=FALSE}
load("./data/data_ganp_kpi_reqs.rda")

gt::gt(data_ganp_kpi_reqs) |> 
  gt::sub_missing(missing_text = "")
```


## Installation

You can install the development version of ansperf from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("euctrl-pru/ansperf")
```

## Example

This is a basic example which shows you how to solve a common problem:

```{r example}
library(ansperf)
## basic example code
```

TO BE CONTINUED .....

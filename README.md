
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ansperf

<!-- badges: start -->
<!-- badges: end -->

Workspace for the development of a GANP/PBWG/BRA-EUR/CHN-EUR informed
package.

The general objective of air navigation services is to enable the “…
safe, efficient, and orderly flow of air traffic.” ICAO promotes further
the use of a performance-based approach and encourages stakeholder to
monitor and benchmark services. For this purpose a set of (global) key
performance indicators (KPI) were established under the Global Air
Navigation Plan. These KPIs (and variants of them) are actively used by
the performance benchmarking community.

This package is jointly developed by the Department of Airspace Control
(DECEA) und EUROCONTROL. Performance groups of both organisations are
committed to further harmonise the use of the KPIs as part of the
bi-lateral and multi-lateral/international work.

The `{ansperf}` package implements the common KPIs and supporting
metrics in `R`.

The project is in its active development phase and may change
frequently.  
Do not hesitate to reach out, if you have an interest in contributing,
testing, or have any other question about the on-going developments.

## Installation

You can install the development version of ansperf from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("euctrl-pru/ansperf")
```

## GANP KPIs

The `performance framework` of the GANP lists the following KPIs (c.f.
<https://www4.icao.int/ganpportal/ASBU/KPI>) and whether `{ansperf}` has
it implemented:

``` r
load("./data/data_ganp_kpi_reqs.rda")

#gt::gt(data_ganp_kpi_reqs) |> 
#  gt::sub_missing(missing_text = "")
tinytable::tt(data_ganp_kpi_reqs)
```

| KPI | name | data-basic | data-advanced | …5 | …6 |
|----|----|----|----|----|----|
| data-type | NA | flight data | ATFM data | meta-data | trajectory data |
| SYS | system characterisation | NA | NA | as required | NA |
| FLT | flight related data | ADEP, ADES | NA | NA | NA |
| KPI01 | departure punctuality | STD/SOBT, AOBT | NA | NA | NA |
| KPI02 | additional taxi-out time | AOBT, ATOT, RWY, STND | NA | NA | NA |
| KPI03 | ATFM slot adherence | ATOT | CTOT | NA | NA |
| KPI04 | filed flight plan route extension | NA | NA | NA | X (flight plan) |
| KPI05 | actual en-route extension | NA | NA | NA | X (actual flown traj) |
| KPI06 | en-route airspace capacity | NA | decl. cap. per sector/FIR | NA | NA |
| KPI07 | en-route ATFM delay | NA | ETOT, CTOT | sector/FIR assoc. | NA |
| KPI08 | add. time in terminal airspace | ALDT, RWY, TYPE | NA | NA | 40/100NM pos. & time |
| KPI09 | airport peak arrival capacity | NA | NA | (max) arrival rates | NA |
| KPI10 | airport peak arrival throughput | ALDT | NA | NA | NA |
| KPI11 | airport arrival capacity utilisation | ALDT, ELDT | NA | arrival capacity | NA |
| KPI12 | airport/terminal ATFM delay | NA | ETOT, CTOT | airport/TMA assoc. | NA |
| KPI13 | additional taxi-in time | ALDT, AIBT, RWY, STND | NA | NA | NA |
| KPI14 | arrival punctuality | STA/SIBT, AIBT | NA | NA | NA |
| KPI15 | flight time variability | AOBT, ATOT, ALDT, AIBT | NA | NA | NA |
| KPI16 | additional fuel burn | based on KPI02, KPI13, KPI05, KPI08 | NA | fuel burn per flight phase or fuel flow/burn data | NA |
| KPI17 | level-off during climb | NA | NA | NA | Level segments within 200NM |
| KPI18 | level capping during cruise | NA | NA | NA | Plan: Max (RFL) last plan, Actual: max cruise FL ; Ref city pair FL |
| KPI19 | level-off during descent | NA | NA | NA | Level segments within 200NM |
| KPI20 | number of aircraft accidents | NA | NA | safety reporting | NA |
| KPI21 | number of runway incursions | NA | NA | safety reporting | NA |
| KPI22 | number of runway excursions | NA | NA | safety reporting | NA |
| KPI23 | Number of airprox/TCAS alert/loss of separation | NA | NA | safety reporting | NA |

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(ansperf)
## basic example code
```

The examples/getting started vignette will be built soon.

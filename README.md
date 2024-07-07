
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ansperf

<!-- badges: start -->
<!-- badges: end -->

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

## GANP KPIs

The `performance framework` of the GANP lists the following KPIs (c.f.
<https://www4.icao.int/ganpportal/ASBU/KPI>) and whether `{ansperf}` has
it implemented:

``` r
load("./data/kpi_data_reqs.rda")

gt::gt(kpi_data_reqs)
```

<div id="yincpfywfh" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#yincpfywfh table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}
&#10;#yincpfywfh thead, #yincpfywfh tbody, #yincpfywfh tfoot, #yincpfywfh tr, #yincpfywfh td, #yincpfywfh th {
  border-style: none;
}
&#10;#yincpfywfh p {
  margin: 0;
  padding: 0;
}
&#10;#yincpfywfh .gt_table {
  display: table;
  border-collapse: collapse;
  line-height: normal;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}
&#10;#yincpfywfh .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}
&#10;#yincpfywfh .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}
&#10;#yincpfywfh .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 3px;
  padding-bottom: 5px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}
&#10;#yincpfywfh .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}
&#10;#yincpfywfh .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#yincpfywfh .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}
&#10;#yincpfywfh .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}
&#10;#yincpfywfh .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}
&#10;#yincpfywfh .gt_column_spanner_outer:first-child {
  padding-left: 0;
}
&#10;#yincpfywfh .gt_column_spanner_outer:last-child {
  padding-right: 0;
}
&#10;#yincpfywfh .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}
&#10;#yincpfywfh .gt_spanner_row {
  border-bottom-style: hidden;
}
&#10;#yincpfywfh .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  text-align: left;
}
&#10;#yincpfywfh .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}
&#10;#yincpfywfh .gt_from_md > :first-child {
  margin-top: 0;
}
&#10;#yincpfywfh .gt_from_md > :last-child {
  margin-bottom: 0;
}
&#10;#yincpfywfh .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}
&#10;#yincpfywfh .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#yincpfywfh .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}
&#10;#yincpfywfh .gt_row_group_first td {
  border-top-width: 2px;
}
&#10;#yincpfywfh .gt_row_group_first th {
  border-top-width: 2px;
}
&#10;#yincpfywfh .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#yincpfywfh .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}
&#10;#yincpfywfh .gt_first_summary_row.thick {
  border-top-width: 2px;
}
&#10;#yincpfywfh .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#yincpfywfh .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#yincpfywfh .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}
&#10;#yincpfywfh .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}
&#10;#yincpfywfh .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}
&#10;#yincpfywfh .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#yincpfywfh .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}
&#10;#yincpfywfh .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#yincpfywfh .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}
&#10;#yincpfywfh .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#yincpfywfh .gt_left {
  text-align: left;
}
&#10;#yincpfywfh .gt_center {
  text-align: center;
}
&#10;#yincpfywfh .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}
&#10;#yincpfywfh .gt_font_normal {
  font-weight: normal;
}
&#10;#yincpfywfh .gt_font_bold {
  font-weight: bold;
}
&#10;#yincpfywfh .gt_font_italic {
  font-style: italic;
}
&#10;#yincpfywfh .gt_super {
  font-size: 65%;
}
&#10;#yincpfywfh .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}
&#10;#yincpfywfh .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}
&#10;#yincpfywfh .gt_indent_1 {
  text-indent: 5px;
}
&#10;#yincpfywfh .gt_indent_2 {
  text-indent: 10px;
}
&#10;#yincpfywfh .gt_indent_3 {
  text-indent: 15px;
}
&#10;#yincpfywfh .gt_indent_4 {
  text-indent: 20px;
}
&#10;#yincpfywfh .gt_indent_5 {
  text-indent: 25px;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    &#10;    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="KPI ">KPI </th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="name">name</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="data-basic">data-basic</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="data-advanced">data-advanced</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="...5">...5</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="...6">...6</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="KPI " class="gt_row gt_left">data-type</td>
<td headers="name" class="gt_row gt_left">NA</td>
<td headers="data-basic" class="gt_row gt_left">flight data</td>
<td headers="data-advanced" class="gt_row gt_left">ATFM data</td>
<td headers="...5" class="gt_row gt_left">meta-data</td>
<td headers="...6" class="gt_row gt_left">trajectory data</td></tr>
    <tr><td headers="KPI " class="gt_row gt_left">SYS</td>
<td headers="name" class="gt_row gt_left">system characterisation</td>
<td headers="data-basic" class="gt_row gt_left">NA</td>
<td headers="data-advanced" class="gt_row gt_left">NA</td>
<td headers="...5" class="gt_row gt_left">as required</td>
<td headers="...6" class="gt_row gt_left">NA</td></tr>
    <tr><td headers="KPI " class="gt_row gt_left">FLT</td>
<td headers="name" class="gt_row gt_left">flight related data</td>
<td headers="data-basic" class="gt_row gt_left">ADEP, ADES</td>
<td headers="data-advanced" class="gt_row gt_left">NA</td>
<td headers="...5" class="gt_row gt_left">NA</td>
<td headers="...6" class="gt_row gt_left">NA</td></tr>
    <tr><td headers="KPI " class="gt_row gt_left">KPI01 </td>
<td headers="name" class="gt_row gt_left">departure punctuality</td>
<td headers="data-basic" class="gt_row gt_left">STD/SOBT, AOBT</td>
<td headers="data-advanced" class="gt_row gt_left">NA</td>
<td headers="...5" class="gt_row gt_left">NA</td>
<td headers="...6" class="gt_row gt_left">NA</td></tr>
    <tr><td headers="KPI " class="gt_row gt_left">KPI02 </td>
<td headers="name" class="gt_row gt_left">additional taxi-out time </td>
<td headers="data-basic" class="gt_row gt_left">AOBT, ATOT, RWY, STND</td>
<td headers="data-advanced" class="gt_row gt_left">NA</td>
<td headers="...5" class="gt_row gt_left">NA</td>
<td headers="...6" class="gt_row gt_left">NA</td></tr>
    <tr><td headers="KPI " class="gt_row gt_left">KPI03 </td>
<td headers="name" class="gt_row gt_left">ATFM slot adherence </td>
<td headers="data-basic" class="gt_row gt_left">ATOT</td>
<td headers="data-advanced" class="gt_row gt_left">CTOT</td>
<td headers="...5" class="gt_row gt_left">NA</td>
<td headers="...6" class="gt_row gt_left">NA</td></tr>
    <tr><td headers="KPI " class="gt_row gt_left">KPI04 </td>
<td headers="name" class="gt_row gt_left">filed flight plan route extension </td>
<td headers="data-basic" class="gt_row gt_left">NA</td>
<td headers="data-advanced" class="gt_row gt_left">NA</td>
<td headers="...5" class="gt_row gt_left">NA</td>
<td headers="...6" class="gt_row gt_left">X (flight plan)</td></tr>
    <tr><td headers="KPI " class="gt_row gt_left">KPI05 </td>
<td headers="name" class="gt_row gt_left">actual en-route extension </td>
<td headers="data-basic" class="gt_row gt_left">NA</td>
<td headers="data-advanced" class="gt_row gt_left">NA</td>
<td headers="...5" class="gt_row gt_left">NA</td>
<td headers="...6" class="gt_row gt_left">X (actual flown traj)</td></tr>
    <tr><td headers="KPI " class="gt_row gt_left">KPI06 </td>
<td headers="name" class="gt_row gt_left">en-route airspace capacity </td>
<td headers="data-basic" class="gt_row gt_left">NA</td>
<td headers="data-advanced" class="gt_row gt_left">decl. cap. per sector/FIR  </td>
<td headers="...5" class="gt_row gt_left">NA</td>
<td headers="...6" class="gt_row gt_left">NA</td></tr>
    <tr><td headers="KPI " class="gt_row gt_left">KPI07 </td>
<td headers="name" class="gt_row gt_left">en-route ATFM delay </td>
<td headers="data-basic" class="gt_row gt_left">NA</td>
<td headers="data-advanced" class="gt_row gt_left">ETOT, CTOT</td>
<td headers="...5" class="gt_row gt_left">sector/FIR assoc.</td>
<td headers="...6" class="gt_row gt_left">NA</td></tr>
    <tr><td headers="KPI " class="gt_row gt_left">KPI08 </td>
<td headers="name" class="gt_row gt_left">add. time in terminal airspace </td>
<td headers="data-basic" class="gt_row gt_left">ALDT, RWY, TYPE</td>
<td headers="data-advanced" class="gt_row gt_left">NA</td>
<td headers="...5" class="gt_row gt_left">NA</td>
<td headers="...6" class="gt_row gt_left">40/100NM pos. &amp; time</td></tr>
    <tr><td headers="KPI " class="gt_row gt_left">KPI09 </td>
<td headers="name" class="gt_row gt_left">airport peak arrival capacity </td>
<td headers="data-basic" class="gt_row gt_left">NA</td>
<td headers="data-advanced" class="gt_row gt_left">NA</td>
<td headers="...5" class="gt_row gt_left">(max) arrival rates</td>
<td headers="...6" class="gt_row gt_left">NA</td></tr>
    <tr><td headers="KPI " class="gt_row gt_left">KPI10 </td>
<td headers="name" class="gt_row gt_left">airport peak arrival throughput </td>
<td headers="data-basic" class="gt_row gt_left">ALDT</td>
<td headers="data-advanced" class="gt_row gt_left">NA</td>
<td headers="...5" class="gt_row gt_left">NA</td>
<td headers="...6" class="gt_row gt_left">NA</td></tr>
    <tr><td headers="KPI " class="gt_row gt_left">KPI11 </td>
<td headers="name" class="gt_row gt_left">airport arrival capacity utilisation </td>
<td headers="data-basic" class="gt_row gt_left">ALDT, ELDT</td>
<td headers="data-advanced" class="gt_row gt_left">NA</td>
<td headers="...5" class="gt_row gt_left">arrival capacity</td>
<td headers="...6" class="gt_row gt_left">NA</td></tr>
    <tr><td headers="KPI " class="gt_row gt_left">KPI12 </td>
<td headers="name" class="gt_row gt_left">airport/terminal ATFM delay </td>
<td headers="data-basic" class="gt_row gt_left">NA</td>
<td headers="data-advanced" class="gt_row gt_left">ETOT, CTOT</td>
<td headers="...5" class="gt_row gt_left">airport/TMA assoc.</td>
<td headers="...6" class="gt_row gt_left">NA</td></tr>
    <tr><td headers="KPI " class="gt_row gt_left">KPI13 </td>
<td headers="name" class="gt_row gt_left">additional taxi-in time </td>
<td headers="data-basic" class="gt_row gt_left">ALDT, AIBT, RWY, STND</td>
<td headers="data-advanced" class="gt_row gt_left">NA</td>
<td headers="...5" class="gt_row gt_left">NA</td>
<td headers="...6" class="gt_row gt_left">NA</td></tr>
    <tr><td headers="KPI " class="gt_row gt_left">KPI14 </td>
<td headers="name" class="gt_row gt_left">arrival punctuality </td>
<td headers="data-basic" class="gt_row gt_left">STA/SIBT, AIBT</td>
<td headers="data-advanced" class="gt_row gt_left">NA</td>
<td headers="...5" class="gt_row gt_left">NA</td>
<td headers="...6" class="gt_row gt_left">NA</td></tr>
    <tr><td headers="KPI " class="gt_row gt_left">KPI15 </td>
<td headers="name" class="gt_row gt_left">flight time variability </td>
<td headers="data-basic" class="gt_row gt_left">AOBT, ATOT, ALDT, AIBT </td>
<td headers="data-advanced" class="gt_row gt_left">NA</td>
<td headers="...5" class="gt_row gt_left">NA</td>
<td headers="...6" class="gt_row gt_left">NA</td></tr>
    <tr><td headers="KPI " class="gt_row gt_left">KPI16 </td>
<td headers="name" class="gt_row gt_left">additional fuel burn </td>
<td headers="data-basic" class="gt_row gt_left">based on KPI02, KPI13, KPI05, KPI08 </td>
<td headers="data-advanced" class="gt_row gt_left">NA</td>
<td headers="...5" class="gt_row gt_left">fuel burn per flight phase or fuel flow/burn data </td>
<td headers="...6" class="gt_row gt_left">NA</td></tr>
    <tr><td headers="KPI " class="gt_row gt_left">KPI17 </td>
<td headers="name" class="gt_row gt_left">level-off during climb </td>
<td headers="data-basic" class="gt_row gt_left">NA</td>
<td headers="data-advanced" class="gt_row gt_left">NA</td>
<td headers="...5" class="gt_row gt_left">NA</td>
<td headers="...6" class="gt_row gt_left">Level segments within 200NM </td></tr>
    <tr><td headers="KPI " class="gt_row gt_left">KPI18 </td>
<td headers="name" class="gt_row gt_left">level capping during cruise </td>
<td headers="data-basic" class="gt_row gt_left">NA</td>
<td headers="data-advanced" class="gt_row gt_left">NA</td>
<td headers="...5" class="gt_row gt_left">NA</td>
<td headers="...6" class="gt_row gt_left">Plan: Max (RFL) last plan, Actual: max cruise FL ; Ref city pair FL  </td></tr>
    <tr><td headers="KPI " class="gt_row gt_left">KPI19 </td>
<td headers="name" class="gt_row gt_left">level-off during descent </td>
<td headers="data-basic" class="gt_row gt_left">NA</td>
<td headers="data-advanced" class="gt_row gt_left">NA</td>
<td headers="...5" class="gt_row gt_left">NA</td>
<td headers="...6" class="gt_row gt_left">Level segments within 200NM </td></tr>
    <tr><td headers="KPI " class="gt_row gt_left">KPI20</td>
<td headers="name" class="gt_row gt_left">number of aircraft accidents</td>
<td headers="data-basic" class="gt_row gt_left">NA</td>
<td headers="data-advanced" class="gt_row gt_left">NA</td>
<td headers="...5" class="gt_row gt_left">safety reporting</td>
<td headers="...6" class="gt_row gt_left">NA</td></tr>
    <tr><td headers="KPI " class="gt_row gt_left">KPI21</td>
<td headers="name" class="gt_row gt_left">number of runway incursions</td>
<td headers="data-basic" class="gt_row gt_left">NA</td>
<td headers="data-advanced" class="gt_row gt_left">NA</td>
<td headers="...5" class="gt_row gt_left">safety reporting</td>
<td headers="...6" class="gt_row gt_left">NA</td></tr>
    <tr><td headers="KPI " class="gt_row gt_left">KPI22</td>
<td headers="name" class="gt_row gt_left">number of runway excursions</td>
<td headers="data-basic" class="gt_row gt_left">NA</td>
<td headers="data-advanced" class="gt_row gt_left">NA</td>
<td headers="...5" class="gt_row gt_left">safety reporting</td>
<td headers="...6" class="gt_row gt_left">NA</td></tr>
    <tr><td headers="KPI " class="gt_row gt_left">KPI23</td>
<td headers="name" class="gt_row gt_left">Number of airprox/TCAS alert/loss of separation</td>
<td headers="data-basic" class="gt_row gt_left">NA</td>
<td headers="data-advanced" class="gt_row gt_left">NA</td>
<td headers="...5" class="gt_row gt_left">safety reporting</td>
<td headers="...6" class="gt_row gt_left">NA</td></tr>
  </tbody>
  &#10;  
</table>
</div>

## Installation

You can install the development version of ansperf from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("euctrl-pru/ansperf")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(ansperf)
## basic example code
```

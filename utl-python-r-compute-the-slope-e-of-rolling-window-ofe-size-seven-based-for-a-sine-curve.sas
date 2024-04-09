%let pgm=utl-python-r-compute-the-slope-e-of-rolling-window-ofe-size-seven-based-for-a-sine-curve;

Python r compute the slope e of rolling window ofe size seven based for a sine curve

github
https://tinyurl.com/y2jmywuw
https://github.com/rogerjdeangelis/utl-python-r-compute-the-slope-e-of-rolling-window-ofe-size-seven-based-for-a-sine-curve

/*               _     _
 _ __  _ __ ___ | |__ | | ___ _ __ ___
| `_ \| `__/ _ \| `_ \| |/ _ \ `_ ` _ \
| |_) | | | (_) | |_) | |  __/ | | | | |
| .__/|_|  \___/|_.__/|_|\___|_| |_| |_|
|_|
*/

   TWO SOLUTIONS

          1 Pyhon sympy
          2 R zoo rolling regression for center points (4th position NNN X NNN       of rolling 7
                                                                     7 ob regression

       Rlated repos on end


/**********************************************************************************************************************************************/
/*                                      |                                                 |                                                   */
/*  1. PYHON SYMPY                      |                                                 |                                                   */
/*  ==============                      |                                                 |                                                   */
/*                                      |         PROCESS                                 |             OUTPUT                                */
/*           INPUT                      |                                                 |                                                   */
/*                                      |    %utl_submit_py64_310("                       |           put &=derivative                        */
/*                                      |    from sympy import *;                         |                                                   */
/*         Y = sine(x)                  |    import pyperclip;                            |           DERIVATIVE=cos(x)                       */
/*                                      |    x = symbols('x');                            |                                                   */
/*                                      |    expr = sin(x);                               |                                                   */
/*                                      |    derivative = diff(expr, x);                  |                                                   */
/*                                      |    derivative =str(derivative)                  |                                                   */
/*                                      |    pyperclip.copy(derivative);                  |                                                   */
/*                                      |    ",return=derivative);                        |                                                   */
/*                                      |                                                 |                                                   */
/*--------------------------------------|-------------------------------------------------|-------------------------------------------------- */
/*                                      |                                                 |                                                   */
/*  2. R ZOO ROLLING REGRESSION         |                                                 |                                                   */
/*  ============================        |                                                 |                                                   */
/*                                      |                                                 |                                                   */
/*  options validvarname=upcase;        | %utl_submit_r64x('                              |                                                   */
/*  libname sd1 "d:/sd1";               | library(zoo);                                   |                        X                          */
/*  data sd1.have;                      | library(haven);                                 |         0         1         2         3           */
/*    do x=0 to constant('pi') by .05;  | library(sqldf);                                 |      ---+---------+---------+---------+----       */
/*       y=sin(x);                      | input<-as.data.frame(                           |      |                                    |       */
/*       z=cos(x);                      |   read_sas("d:/sd1/have.sas7bdat"));            |      |                                    |       */
/*       output;                        | regr <- function(x, indepvar, depvar) {         |  1.0 +    *          #######   Input Sine +  1.0  */
/*    end;                              |   a <- coef(lm(                                 |      |       *     ###  |  ###            |       */
/*  run;quit;                           |      as.formula(paste(indepvar, "~", depvar))   |      | Slope-> * ##     |     ##          |       */
/*                                      |     ,data = x));                                |      | Cosine   **      |      ##         |       */
/*                                      |   return(a);                                    |      |        ## **     |        ##       |       */
/*  d:/sd1/have                         | };                                              |  0.5 +       ##   **    |         ##      +  0.5  */
/*                                      | want<-as.data.frame(rollapplyr(input[,1:2]      |      |      ##      *   |          ##     |       */
/*  sd1.have                            |  ,width = 7                                     |      |     ##        *  |           ##    |       */
/*                                      |  ,FUN = function(x)                             |   Y  |    ##          * |            ##   |       */
/*  Obs      X   Y (Sine of X)          |     regr(as.data.frame(x), "Y", "X"),           |      |    #            *|             ##  |       */
/*                                      |  by.column = FALSE));                           |  0.0 +------------------*--------------#- +  0.0  */
/*    1    0.00    0.00000              | want;                                           |      |                  |*                |       */
/*    2    0.05    0.04998              | want<-sqldf("                                   |      |                  | *               |       */
/*    3    0.10    0.09983              |   select                                        |      |   Solutions        *               |       */
/*    4    0.15    0.14944              |      inp.x   as x                               |      |   SYMPY cos(x)<---- *              |       */
/*    5    0.20    0.19867              |     ,inp.y   as sine                            |  0.5 +   R ROLL 7       |    *            + -0.5  */
/*    6    0.25    0.24740              |     ,inp.z   as exact_cosine                    |      |                  |     *           |       */
/*    7    0.30    0.29552              |     ,slope.x as sine_slope                      |      |                  |      *          |       */
/*    8    0.35    0.34290              |     ,inp.z - slope.x as dif                     |      |                  |        *        |       */
/*    9    0.40    0.38942              |   from                                          |      |                  |          *      |       */
/*  ...                                 |      (select                                    |  1.0 +                  |             *   + -1.0  */
/*                                      |         *                                       |      ---+---------+---------+---------+----       */
/*  59    2.90    0.23925               |        ,row_number() over () as row_input       |         0         1     X   2         3           */
/*  60    2.95    0.19042               |      from                                       |                                                   */
/*  61    3.00    0.14112               |         input) as inp                           |                                                   */
/*  62    3.05    0.09146               |   inner                                         |                      EXACT_     SINE_             */
/*  63    3.10    0.04158               |      join                                       |       X      SINE    COSINE     SLOPE       DIF   */
/*                                      |                                                 |                                                   */
/*                                      |      (select                                    |   0.150     0.149     0.989     0.986     0.003   */
/*                                      |         *                                       |   0.200     0.199     0.980     0.977     0.003   */
/*                                      |        ,row_number() over () as row_slope       |   0.250     0.247     0.969     0.966     0.003   */
/*                                      |      from                                       |   0.300     0.296     0.955     0.953     0.003   */
/*                                      |         want) as slope                          |   0.350     0.343     0.939     0.937     0.003   */
/*                                      |   on                                            |   ...                                             */
/*                                      |      (case                                      |   2.900     0.239    -0.971    -0.968    -0.003   */
/*                                      |         when inp.row_input > 3                  |   2.950     0.190    -0.982    -0.979    -0.003   */
/*                                      |         then inp.row_input - 3                  |   3.000     0.141    -0.990    -0.987    -0.003   */
/*                                      |         else null                               |   3.050     0.091    -0.996    -0.993    -0.003   */
/*                                      |       end) = slope.row_slope                    |   3.100     0.042    -0.999    -0.996    -0.003   */
/*                                      |   ");                                           |                                                   */
/*                                      | want;                                           |                                                   */
/*                                      | source("c:/temp/fn_tosas9.r");                  |                                                   */
/*                                      | fn_tosas9(dataf=want);                          |                                                   */
/*                                      | ');                                             |                                                   */
/*                                      |                                                 |                                                   */
/*                                      | libname tmp "c://temp";                         |                                                   */
/*                                      |                                                 |                                                   */
/*                                      | proc print data=tmp.want(drop=rownames);        |                                                   */
/*                                      | format _numeric_ 6.3;                           |                                                   */
/*                                      | run;quit;                                       |                                                   */
/*                                      |                                                 |                                                   */
/**********************************************************************************************************************************************/

/*               _   _
/ |  _ __  _   _| |_| |__   ___  _ __    ___ _   _ _ __ ___  _ __  _   _
| | | `_ \| | | | __| `_ \ / _ \| `_ \  / __| | | | `_ ` _ \| `_ \| | | |
| | | |_) | |_| | |_| | | | (_) | | | | \__ \ |_| | | | | | | |_) | |_| |
|_| | .__/ \__, |\__|_| |_|\___/|_| |_| |___/\__, |_| |_| |_| .__/ \__, |
 _  |_|    |___/     _                       |___/          |_|    |___/
(_)_ __  _ __  _   _| |_
| | `_ \| `_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
*/


  Find the slope dy/dx of

  Y = SINE(X)

/*
 _ __  _ __ ___   ___ ___  ___ ___
| `_ \| `__/ _ \ / __/ _ \/ __/ __|
| |_) | | | (_) | (_|  __/\__ \__ \
| .__/|_|  \___/ \___\___||___/___/
|_|
*/

%utl_submit_py64_310("
from sympy import *;
import pyperclip;
x = symbols('x');
expr = sin(x);
derivative = diff(expr, x);
derivative =str(derivative)
pyperclip.copy(derivative);
",return=derivative);

/*           _               _
  ___  _   _| |_ _ __  _   _| |_
 / _ \| | | | __| `_ \| | | | __|
| (_) | |_| | |_| |_) | |_| | |_
 \___/ \__,_|\__| .__/ \__,_|\__|
                |_|
*/

put &=derivative

DERIVATIVE=cos(x)


/*___                     _ _ _
|___ \   _ __   _ __ ___ | | (_)_ __   __ _   _ __ ___  __ _ _ __ ___  ___ ___(_) ___  _ __
  __) | | `__| | `__/ _ \| | | | `_ \ / _` | | `__/ _ \/ _` | `__/ _ \/ __/ __| |/ _ \| `_ \
 / __/  | |    | | | (_) | | | | | | | (_| | | | |  __/ (_| | | |  __/\__ \__ \ | (_) | | | |
|_____| |_|    |_|  \___/|_|_|_|_| |_|\__, | |_|  \___|\__, |_|  \___||___/___/_|\___/|_| |_|
 _                   _                |___/            |___/
(_)_ __  _ __  _   _| |_
| | `_ \| `_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
*/


options validvarname=upcase;
libname sd1 "d:/sd1";
data sd1.have;
  do x=0 to constant('pi') by .05;
     y=sin(x);
     z=cos(x);
     output;
  end;
run;quit;


/**************************************************************************************************************************/
/*                                                                                                                        */
/*  d:/sd1/have                                                                                                           */
/*                                                                                                                        */
/*  sd1.have                                                                                                              */
/*                                                                                                                        */
/*  Obs      X   Y (Sine)     Z(exact cosine)                                                                             */
/*                                                                                                                        */
/*    1    0.00    0.00000      1.00000                                                                                   */
/*    2    0.05    0.04998      0.99875                                                                                   */
/*    3    0.10    0.09983      0.99500                                                                                   */
/*    4    0.15    0.14944      0.98877                                                                                   */
/*    5    0.20    0.19867      0.98007                                                                                   */
/*    6    0.25    0.24740      0.96891                                                                                   */
/*    7    0.30    0.29552      0.95534                                                                                   */
/*    8    0.35    0.34290      0.93937                                                                                   */
/*    9    0.40    0.38942      0.92106                                                                                   */
/*  ...                                                                                                                   */
/*  59    2.90    0.23925      -0.97096                                                                                   */
/*  60    2.95    0.19042      -0.98170                                                                                   */
/*  61    3.00    0.14112      -0.98999                                                                                   */
/*  62    3.05    0.09146      -0.99581                                                                                   */
/*  63    3.10    0.04158      -0.99914                                                                                   */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*
 _ __  _ __ ___   ___ ___  ___ ___
| `_ \| `__/ _ \ / __/ _ \/ __/ __|
| |_) | | | (_) | (_|  __/\__ \__ \
| .__/|_|  \___/ \___\___||___/___/
|_|
*/



  d:/sd1/have

  sd1.have

  Obs      X   Y (Sine)     Z(exact cosine)

    1    0.00    0.00000      1.00000
    2    0.05    0.04998      0.99875
    3    0.10    0.09983      0.99500
    4    0.15    0.14944      0.98877
    5    0.20    0.19867      0.98007
    6    0.25    0.24740      0.96891
    7    0.30    0.29552      0.95534
    8    0.35    0.34290      0.93937
    9    0.40    0.38942      0.92106
  ...
  59    2.90    0.23925      -0.97096
  60    2.95    0.19042      -0.98170
  61    3.00    0.14112      -0.98999
  62    3.05    0.09146      -0.99581
  63    3.10    0.04158      -0.99914

/*
 _ __  _ __ ___   ___ ___  ___ ___
| `_ \| `__/ _ \ / __/ _ \/ __/ __|
| |_) | | | (_) | (_|  __/\__ \__ \
| .__/|_|  \___/ \___\___||___/___/
|_|
*/

%utl_submit_r64x('
library(zoo);
library(haven);
library(sqldf);
input<-as.data.frame(
  read_sas("d:/sd1/have.sas7bdat"));
regr <- function(x, indepvar, depvar) {
  a <- coef(lm(
     as.formula(paste(indepvar, "~", depvar))
    ,data = x));
  return(a);
};
want<-as.data.frame(rollapplyr(input[,1:2]
 ,width = 7
 ,FUN = function(x)
    regr(as.data.frame(x), "Y", "X"),
 by.column = FALSE));
want;
want<-sqldf("
  select
     inp.x   as x
    ,inp.y   as sine
    ,inp.z   as exact_cosine
    ,slope.x as sine_slope
    ,inp.z - slope.x as dif
  from
     (select
        *
       ,row_number() over () as row_input
     from
        input) as inp
  inner
     join

     (select
        *
       ,row_number() over () as row_slope
     from
        want) as slope
  on
     (case
        when inp.row_input > 3
        then inp.row_input - 3
        else null
      end) = slope.row_slope
  ");
want;
source("c:/temp/fn_tosas9.r");
fn_tosas9(dataf=want);
');

libname tmp "c://temp";

proc print data=tmp.want(drop=rownames);
format _numeric_ 6.3;
run;quit;

/*           _               _
  ___  _   _| |_ _ __  _   _| |_
 / _ \| | | | __| `_ \| | | | __|
| (_) | |_| | |_| |_) | |_| | |_
 \___/ \__,_|\__| .__/ \__,_|\__|
                |_|
*/

/**************************************************************************************************************************/
/*                                                                                                                        */
/*                                                                                                                        */
/*                        X                                                                                               */
/*         0         1         2         3                                                                                */
/*      ---+---------+---------+---------+----                                                                            */
/*      |                                    |                                                                            */
/*      |                                    |                                                                            */
/*  1.0 +    *          #######   Input Sine +  1.0                                                                       */
/*      |       *     ###  |  ###            |                                                                            */
/*      | Slope-> * ##     |     ##          |                                                                            */
/*      |          **      |      ##         |                                                                            */
/*      |        ## **     |        ##       |                                                                            */
/*  0.5 +       ##   **    |         ##      +  0.5                                                                       */
/*      |      ##      *   |          ##     |                                                                            */
/*      |     ##        *  |           ##    |                                                                            */
/*   Y  |    ##          * |            ##   |                                                                            */
/*      |    #            *|             ##  |                                                                            */
/*  0.0 +------------------*--------------#- +  0.0                                                                       */
/*      |                  |*                |                                                                            */
/*      |                  | *               |                                                                            */
/*      |   Solutions        *               |                                                                            */
/*      |   SYMPY cos(x)<---- *              |                                                                            */
/*  0.5 +   R ROLL 7       |    *            + -0.5                                                                       */
/*      |                  |     *           |                                                                            */
/*      |                  |      *          |                                                                            */
/*      |                  |        *        |                                                                            */
/*      |                  |          *      |                                                                            */
/*  1.0 +                  |             *   + -1.0                                                                       */
/*      ---+---------+---------+---------+----                                                                            */
/*         0         1     X   2         3                                                                                */
/*                                                                                                                        */
/*                                                                                                                        */
/*                      EXACT_     SINE_                                                                                  */
/*       X      SINE    COSINE     SLOPE       DIF                                                                        */
/*                                                                                                                        */
/*   0.150     0.149     0.989     0.986     0.003                                                                        */
/*   0.200     0.199     0.980     0.977     0.003                                                                        */
/*   0.250     0.247     0.969     0.966     0.003                                                                        */
/*   0.300     0.296     0.955     0.953     0.003                                                                        */
/*   0.350     0.343     0.939     0.937     0.003                                                                        */
/*   ...                                                                                                                  */
/*   2.900     0.239    -0.971    -0.968    -0.003                                                                        */
/*   2.950     0.190    -0.982    -0.979    -0.003                                                                        */
/*   3.000     0.141    -0.990    -0.987    -0.003                                                                        */
/*   3.050     0.091    -0.996    -0.993    -0.003                                                                        */
/*   3.100     0.042    -0.999    -0.996    -0.003                                                                        */
/*                                                                                                                        */
/**************************************************************************************************************************/


 REPO
 -------------------------------------------------------------------------------------------------------------------------------
 https://github.com/rogerjdeangelis/utl-calculating-the-cube-root-of-minus-one-with-drop-down-to-python-symbolic-math-sympy
 https://github.com/rogerjdeangelis/utl-distance-between-a-point-and-curve-in-sql-and-wps-pythony-r-sympy
 https://github.com/rogerjdeangelis/utl-maximum-liklihood-regresssion-wps-python-sympy
 https://github.com/rogerjdeangelis/utl-solve-a-system-of-simutaneous-equations-r-python-sympy
 https://github.com/rogerjdeangelis/utl-symbolic-algebraic-simplification-of-a-polynomial-expressions-sympy
 https://github.com/rogerjdeangelis/utl-sympy-technique-for-symbolic-integration-of-bivariate-density-function


 https://github.com/rogerjdeangelis/utl-Rolling-four-month-median-by-group
 https://github.com/rogerjdeangelis/utl-betas-for-rolling-regressions
 https://github.com/rogerjdeangelis/utl-calculating-three-year-rolling-moving-weekly-and-annual-daily-standard-deviation
 https://github.com/rogerjdeangelis/utl-compute-the-partial-and-total-rolling-sums-for-window-of-size-of-three
 https://github.com/rogerjdeangelis/utl-controlling-the-order-of-transposed-variables-using-interleave-set
 https://github.com/rogerjdeangelis/utl-creating-rolling-sets-of-monthly-tables
 https://github.com/rogerjdeangelis/utl-how-to-compare-price-observations-in-rolling-time-intervals
 https://github.com/rogerjdeangelis/utl-parallell-processing-a-rolling-moving-three-month-ninety-day-skewness-for-five-thousand-variable
 https://github.com/rogerjdeangelis/utl-rolling-moving-sum-and-count-over-3-day-window-by-id
 https://github.com/rogerjdeangelis/utl-rolling-sum_of-six-months-by-group
 https://github.com/rogerjdeangelis/utl-timeseries-rolling-three-day-averages-by-county
 https://github.com/rogerjdeangelis/utl-tumbling-goups-of-ten-temperatures-similar-like-rolling-and-moving-means-wps-r-python
 https://github.com/rogerjdeangelis/utl-weight-loss-over-thirty-day-rolling-moving-windows-using-weekly-values
 https://github.com/rogerjdeangelis/utl_calculate-moving-rolling-average-with-gaps-in-years
 https://github.com/rogerjdeangelis/utl_calculating_rolling_3_month_skewness_of_prices_by_stock
 https://github.com/rogerjdeangelis/utl_calculating_the_rolling_product_using_wps_sas_and_r
 https://github.com/rogerjdeangelis/utl_comparison_sas_v_r_increment_a_rolling_sum_with_the_first_value_for_each_id
 https://github.com/rogerjdeangelis/utl_count_distinct_ids_in_rolling_overlapping_date_ranges
 https://github.com/rogerjdeangelis/utl_excluding_rolling_regressions_with_one_on_more_missing_values_in_the_window
 https://github.com/rogerjdeangelis/utl_nice_hash_example_of_rolling_count_of_dates_plus-minus_2_days_of_current_date
 https://github.com/rogerjdeangelis/utl_rolling_means_by-quarter_semiannual_and_yearly
 https://github.com/rogerjdeangelis/utl_standard_deviation_of_90_day_rolling_standard_deviations

 https://github.com/rogerjdeangelis/utl-forecast-the-next-four-months-using-a-moving-average-time-series
 https://github.com/rogerjdeangelis/utl-forecast-the-next-seven-days-using-a--moving-average-model-in-R
 https://github.com/rogerjdeangelis/utl-moving-ten-month-average-by-group
 https://github.com/rogerjdeangelis/utl-removing-duplicate-substrings
 https://github.com/rogerjdeangelis/utl-weighted-moving-sum-for-several-variables
 https://github.com/rogerjdeangelis/utl_R_moving_average_six_variables_by_group
 https://github.com/rogerjdeangelis/utl_moving_average_of_centered_timeseries_or_calculate_a_modified_version_of_moving_averages


/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/

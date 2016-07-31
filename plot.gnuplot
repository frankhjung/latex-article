#!/usr/bin/env gnuplot

# set title "Normal (Gaussian) Distribution"
set terminal postscript eps enhanced color
set output "plot.eps"

y(x) = exp(-(x**2 / 2)) / sqrt(2 * pi)

unset key

set bmargin 4
set border 3
set xzeroaxis
set xtics nomirror
set ytics nomirror

set label "1-{/Symbol a}" at 0.0, 0.2 center
set label "{/Symbol a}" at 1.8, 0.04 center
set label "z_{/Symbol a}" at 1.5, -0.03 center
set style line 11 linetype 1 linewidth 1
set style arrow 12 nohead linestyle 11
set arrow from 1.5, 0.0 to 1.5, y(1.5) as 12

plot [-3.4:3.4] y(x)

quit

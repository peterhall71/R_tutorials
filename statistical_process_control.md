# Statistical Process Control Using R

Statistical process control (SPC) is an important part of the development of any manufacturing process.
SPC is so versatile that it is even used outside of manufacturing, most commonly in software development and business processes.
One of the many advantages of using R for SPC and other types of statistical analysis is the cost — R is free to use — and the ability to customize output, reproducibility, and repeatability.
Compare that to the cost of other commonly used platforms:

* SPC for Excel: $269 Single User License
* SigmaXL: $300 Single User License
* Minitab: $1200 Single User Annual License
* JMP: $1500 Single User Annual License

## The qcc Package

In this walkthrough, we’re going to focus on control charts and process capability for continuous data.
The qcc package makes this exceptionally easy.
With just a few lines of R code, you can perform the same analysis as the other, more expensive software packages mentioned earlier.
The qcc package was developed specifically to enable users to perform statistical process control routines.
The package contains functions for:

* Shewhart quality control charts for continuous, attribute and count data
* Cusum and EWMA charts
* Operating characteristic curves
* Process capability analysis
* Pareto chart and cause-and-effect chart
* Multivariate control charts

### Control Charts

For this example, we are going to work with the pistonrings dataset included with the qcc package.
To start, we load the package and pistonrings data.
I went ahead and converted the samples column from integer to factor.
We can take a look at the data structure with the str() function.
Here we can see there are a total of 40 samples and 200 observations.
Therefore, a sample size of 5 was used during data collection.
 
<p align="center">
<img src="https://github.com/peterhall71/R_tutorials/blob/master/images/spc_load_data.png" alt="spc load data" width="600"/>
</p>

It is a good idea to check the shape of any data you are working with using a histogram or some other visual representation.
The result shows us the data is normally distributed, which is what we would expect from most manufacturing processes.
If it was non-normal, or too heavily skewed, we would not be able to use control charts until we worked out what was causing the issue.

<p align="center">
<img src="https://github.com/peterhall71/R_tutorials/blob/master/images/spc_histogram.png" alt="spc histogram" width="400"/>
</p>

Currently, the data is in one column, with the sample column indicating the grouping.
The qcc function needs each sample to be in one row, so we will need to use the qcc.groups() function to reshape the data.

<p align="center">
<img src="https://github.com/peterhall71/R_tutorials/blob/master/images/spc_grouping.png" alt="spc grouping" width="500"/>
</p>

Knowing the first 30 samples are “in control,” we will use this subset as calibration data from the charts.
Below we will use the qcc() function to create an Xbar chart from our data.
Normally, you would include an R chart as well, but today we will leave that part out of the example.

The remaining samples — those we want to compare to the baseline — will be included using the “newdata” argument.
When analyzing a live production line, the incoming samples would be include using this argument for each analysis interval.

The UCL (upper controlled limit) and LCL (lower control limit) are calculated as mean ± nsigma.
The default for qcc is nsigma= 3 , meaning ±3 standard deviations of the mean.
However, nsigma and the confidence interval can be changed.

<p align="center">
<img src="https://github.com/peterhall71/R_tutorials/blob/master/images/spc_summary.png" alt="spc summary" width="600"/>
</p>

You can see from the Xbar chart that the 30 calibration group observations are “in control.”
However, our new data is “out of control,” and our process may be experiencing some drift or shift.
In practice, we would need to pause production, and most likely, initiate root-cause-analysis to uncover the issue.

<p align="center">
<img src="https://github.com/peterhall71/R_tutorials/blob/master/images/spc_control_chart.png" alt="spc control chart" width="600"/>
</p>

### Process Capability

While control charts compare the process to past performance, process capability compares the process to the customers’ requirements.
This allows us to check if the control limits and specification limits are in sync with each other.

For our example, we can say that the client wanted piston rings with a target diameter of 74 with a deviation of +/- 0.02.
Process capability will help us identify whether our system is capable of meeting the specified requirements.
 
 <p align="center">
<img src="https://github.com/peterhall71/R_tutorials/blob/master/images/spc_capability.png" alt="spc capability" width="600"/>
</p>

\*Note that the process.capability() function does not include the “newdata” argument in its analysis.

In the below plot, red lines indicate the target value — the lower and upper specified range.
For a capable process, the value of Cpk should be higher than 1.33. Our result is 0.638.
Based on the fitted distribution, we can expect over 4% of our product to be out of spec.
Depending on the industry, this may be an acceptable scrap rate, but for most mid- to high-volume operations, the scrap cost will be too high.

<p align="center">
<img src="https://github.com/peterhall71/R_tutorials/blob/master/images/spc_capability_chart.png" alt="spc capability chart" width="600"/>
</p>

## The Final Word on qcc

The qcc package — and thousands of other powerful R packages — enable the user to perform any necessary analysis without expensive software.
There is a learning curve associated with switching away from spreadsheet-based analysis.
Still, it opens up a lot of opportunities for customized analysis and output and easily handles massive datasets.


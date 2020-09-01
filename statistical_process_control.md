# Statistical Process Control Using R

Statistical process control (SPC) is an important part of the development of any manufacturing process.
In fact, SPC is so versatile that it is used outside of manufacturing as well, most commonly in software development and business processes.
Some of the platforms that are commonly used to perform SPC are listed below, along with the costs.
On of the many advantages of using R for SPC and other types of statistical analysis is the cost, along with the ability to customize output, reproducibility, and repeatability.

* SPC for Excel $269 Single User License
* SigmaXL $300 Single User License
* Minitab $1200 Single User Annual License
* JMP $1500 Single User Annual License

## The qcc Package

The qcc package was developed specifically to enable users to perform statistical process control routines.
The package contains functions for:

* Shewhart quality control charts for continuous, attribute and count data
* Cusum and EWMA charts
* Operating characteristic curves
* Process capability analysis
* Pareto chart and cause-and-effect chart
* Multivariate control charts

During the walkthrough we are going to focus on just control charts and process capability for continuous data.
The qcc package makes this exceptionally easy.
With just a few lines of R code you can perform the same analysis as the other software packages mentioned earlier.

## Control Charts

For this example we are going to work with the pistonrings dataset that is included with the qcc package.
To start, we load the package and pistonrings data.
I went ahead and converted the samples column from integer to factor.
We can take a look at the data structure with the str() function.
Here we can see there are a total of 40 samples and 200 observations.
Therefore, a sample size of 5 was used during data collection.
 

It is a good idea to check the shape of any data you are working with using a histogram or some other visual representation.
The result shows us the data is normally distributed, which is what we would expect from most manufacturing processes.
If it was non-normal, or too heavily skewed, we would not be able to use control charts until we worked out what was causing the issue.

Currently, the data is in one column, with the sample column indicating the grouping.
The qcc function needs each sample to be in one row, so we will need to use the qcc.groups() function to reshape the data.

Knowing the first 30 samples are in control, we will use this subset as calibration data from the charts.
Below we will use the qcc() function to create and Xbar chart from our data.
Normally you would include an R chart as well, but today we will leave that part out of the example.

The remaining samples will be included using newdata=, these are the samples we want to compare to the baseline.
When analyzing a live production line the incoming samples would be included in this “newdata” object for each analysis interval.

The UCL (upper controlled limit) and LCL (lower control limit) are calculated as mean ± nsigma.
The default for qcc is nsigma= 3 , meaning ±3 standard deviations of the mean.
However, nsigma and the confidence interval can be changed.

It can be seen below that the 30 calibration group observations are “in control.”
However, our new data is “out of control” and our process may be experiencing some drift or shift.
In practice, production would need to be paused and most likely root-cause-analysis would need to be initiated to uncover the issue.

## Process Capability

While control charts compare the process to past performance, process capability compares the process to the customers’ requirements.
This allows us to check if the control limits and specification limits are in sync with each other.
For our example we can say that the client wanted piston rings with target diameter of 74 with a deviation of +/- 0.02.
Process capability will help us in identifying whether our system is capable to meeting the specified requirements.
 
Note that the process.capability() function does not include the “newdata” object in its analysis.
In the below plot, red lines indicate the target value, the lower and upper specified range.
For a capable process, the value of Cpk should be higher than 1.33.
Our result is 0.638. Based on the fitted distribution we can expect over 4% of our product to be out of spec.
Depending on the industry this may be an acceptable scrap rate, but for most mid to high volume operations the scrap cost will be too high.

 

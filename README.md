# Level Set Alogorithm Based on Chan Vese Model
# Guide
This is an MATLAB implementation by HSW in 2015.4.12 (HARBIN INSTITUTE OF TECHNOLOGY). But there was several mistakes on the original code and I fixed them to make sure it can process properly.

The entrance is levelset_CV.m, and you can run it with any chosen policy of initialization.

I add the return of c1 and c2, which are the average values of inside and out side the contour respectively. As the origin level set alogorithm cannot distinguish background and front, I hope the returned value will help with it.
# References
[Chan–Vese Segmentation (Pascal Getreuer) and its c implementation]
(http://www.ipol.im/pub/art/2012/g-cv/?utm_source=doi)

[The original matlab implementation]
(https://blog.csdn.net/hit1524468/article/details/79682837)

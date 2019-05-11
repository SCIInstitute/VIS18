function [signSaddleMeanField, signMidpointMeanField] = getMeanFieldSign(m1, m2, m3, m4, k)


saddleValue =  (m1*m2 - m1*m3)/ (m1+m2-m3-m4)

midpointValue = (m1 + m2 + m3 + m4)/4

if(saddleValue < k)
    signSaddleMeanField = -1;
else
     signSaddleMeanField = 1;
end

if(midpointValue < k)
    signMidpointMeanField = -1;
else
     signMidpointMeanField = 1;
end



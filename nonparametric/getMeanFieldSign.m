function [signSaddleMeanField, signMidpointMeanField] = getMeanFieldSign(m1, m2, m3, m4, k)


saddleMeanFieldValue =  (m1*m2 - m3*m4)/ (m1+m2-m3-m4)

midpointMeanFieldValue = (m1 + m2 + m3 + m4)/4

if(saddleMeanFieldValue < k)
    signSaddleMeanField = -1;
else
     signSaddleMeanField = 1;
end

if(midpointMeanFieldValue < k)
    signMidpointMeanField = -1;
else
     signMidpointMeanField = 1;
end



classdef HaarFeatures
    %HAARFEATURES Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        r;
        c;
        winWidth;
        winHeight;
        featureType;
        
        meanPos;
        sdPos;
        maxPos;
        minPos;
        clNo;
        alpha;
        error;
        falseNegError;
        falsePosError;
        
        
    end
    
    methods
        function obj=HaarFeatures(attributes)
            obj.r=attributes(1,1);
            obj.c=attributes(2,1);
            obj.winWidth=attributes(3,1);
            obj.winHeight=attributes(4,1);
            obj.featureType=attributes(5,1);

            obj.meanPos=attributes(6,1);
            obj.sdPos=attributes(7,1);
            obj.maxPos=attributes(8,1);
            obj.minPos=attributes(9,1);
            obj.clNo=attributes(10,1);
            obj.alpha=attributes(11,1);
            obj.error=attributes(12,1);
            obj.falseNegError=attributes(13,1);
            obj.falsePosError=attributes(14,1);
            
        end
        
        function val=haarFeaturesCompute(integralImage)
            tempval=0;
            switch obj.clNo
                case 1
                    Rectangle1 =[obj.r obj.c ((obj.winWidth/2)-1) (obj.winHeight -1)];
                    Rectangle2 = [obj.r (obj.c + obj.winWidth/2) ((obj.winWidth/2) - 1) (obj.winHeight - 1)]
                    
                    rect1val =calculateRectangle(integralImage,Rectangle1);
                    rect2val =calculateRectangle(integralImage,Rectangle2);
                    
                    tempval = rect1val+rect2val;
                case 2
                    tempval =0;
                case 3
                    tempval=0;
                case 4
                    tempval = 0;
                case 5
                    tempval = 0;
            end
            val=tempval;
        end
        
        function val=calculateRectangle(integralImage,rectangle)
            topleftx = rectange(1);
            toplefty = rectangle(2);
            
            toprightx=rectangle(1) + rectangle(3);
            toprighty=rectangle(2);
            
            bottomleftx = rectangle(1);
            bottomlefty = rectangle(2) + rectangle(4);
            
            bottomrightx = rectangle(1) + rectangle(3);
            bottomrighty = rectangle(2) + rectangle(4);
            
            topleftval = integralImage(topleftx,toplefty);
            toprightval = integralImage(toprightx,toprighty);
            bottomleftval = integralImage(bottomleftx,bottomlefty);
            bottomrightval = integralImage(bottomrightx,bottomrighty);
            
            val = bottomrightval - bottomleftval - toprightval +topleftval;
        end
    end
    
end


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
        
        function val=haarFeaturesCompute(obj,integralImage)
            tempval=0;
            switch obj.featureType
                case 1
                    Rectangle1 =[obj.r obj.c ((obj.winWidth/2)-1) (obj.winHeight -1)];
                    Rectangle2 = [obj.r (obj.c + obj.winWidth/2) ((obj.winWidth/2) - 1) (obj.winHeight - 1)];
                    
                    rect1val =calculateRectangle(obj,integralImage,Rectangle1);
                    rect2val =calculateRectangle(obj,integralImage,Rectangle2);
                    
                    tempval = rect1val+rect2val;
                case 2
                    Rectangle1= [obj.r obj.c (obj.winWidth - 1) ((obj.winHeight/2) - 1)];
                    Rectangle2= [(obj.r + obj.winHeight/2) obj.c (obj.winWidth - 1) ((obj.winHeight/2) - 1)];
                   
                    rect1val =calculateRectangle(obj,integralImage,Rectangle1);
                    rect2val =calculateRectangle(obj,integralImage,Rectangle2);
                    
                    tempval =rect1val+rect2val;
                case 3
                    Rectangle1= [obj.r obj.c ((obj.winWidth/3) - 1) (obj.winHeight - 1)];
                    Rectangle2= [obj.r (obj.c + (obj.winWidth/3)) ((obj.winWidth/3) - 1) (obj.winHeight - 1)];
                    Rectangle3= [obj.r (obj.c + ((2 * obj.winWidth)/3)) ((obj.winWidth/3) - 1) (obj.winHeight - 1)];
                
                    rect1val =calculateRectangle(obj,integralImage,Rectangle1);
                    rect2val =calculateRectangle(obj,integralImage,Rectangle2);
                    rect3val =calculateRectangle(obj,integralImage,Rectangle3);
                    tempval =rect1val-rect2val+rect3val;
                case 4
                    
                    Rectangle1= [obj.r obj.c (obj.winWidth - 1) ((obj.winHeight/3) - 1)];
                    Rectangle2= [(obj.r + (obj.winHeight/3)) obj.c (obj.winWidth - 1) ((obj.winHeight/3) - 1)];
                    Rectangle3= [(obj.r + ((2 * obj.winHeight)/3)) obj.c (obj.winWidth - 1) ((obj.winHeight/3) - 1)];
                   
                    rect1val =calculateRectangle(obj,integralImage,Rectangle1);
                    rect2val =calculateRectangle(obj,integralImage,Rectangle2);
                    rect3val =calculateRectangle(obj,integralImage,Rectangle3);
                    tempval =rect1val-rect2val+rect3val;
                case 5
                    Rectangle1= [obj.r obj.c (obj.winWidth/2 - 1) (obj.winHeight/2 - 1)];
                    Rectangle2= [obj.r (obj.c + obj.winWidth/2) (obj.winWidth/2 - 1) (obj.winHeight/2 - 1)];
                    Rectangle3= [(obj.r + obj.winHeight/2) obj.c (obj.winWidth/2 - 1) (obj.winHeight/2 - 1)];
                    Rectangle4= [(obj.r+obj.winHeight/2) (obj.c+obj.winWidth/2) (obj.winWidth/2-1) (obj.winHeight/2-1)];
                    rect1val =calculateRectangle(obj,integralImage,Rectangle1);
                    rect2val =calculateRectangle(obj,integralImage,Rectangle2);
                    rect3val =calculateRectangle(obj,integralImage,Rectangle3);
                    rect4val =calculateRectangle(obj,integralImage,Rectangle4);
                    tempval =rect1val-rect2val+rect3val -rect4val;
            end
            val=tempval;
        end
        
        function val=calculateRectangle(obj,integralImage,rectangle)
            topleftrow = rectangle(1);
            topleftcolumn = rectangle(2);
            
            toprightrow=rectangle(1) ;
            toprightcolumn=rectangle(2)+ rectangle(3);
            
            bottomleftrow = rectangle(1) + rectangle(4);
            bottomleftcolumn = rectangle(2);
            
            bottomrightrow = rectangle(1) + rectangle(4);
            bottomrightcolumn = rectangle(2) + rectangle(3);
            
            topleftval = integralImage(topleftrow-1 ,topleftcolumn-1);
            toprightval = integralImage(toprightrow-1,toprightcolumn);
            bottomleftval = integralImage(bottomleftrow,bottomleftcolumn-1);
            bottomrightval = integralImage(bottomrightrow,bottomrightcolumn);
            
            val = bottomrightval - bottomleftval - toprightval +topleftval;
        end
    end
    
end


close all;

I=imread('sequence/2043_000140.jpeg');

imshow(I);

 

hold on;

[X,Y]=getpts();

 

xmin = X(1);

xmax=X(2);

 

ymin=Y(1);

ymax =Y(2);


xwidth=xmax-xmin; 
yheight =ymax-ymin;

xc=xmin+(xwidth)/2 ;

yc=ymin+(yheight)/2 ;

 

H=colorHist(I,[xmin ymin;xmax ymax]);

 

for imgNo=141:190

    I2Name=getImageName(imgNo);

    I2=imread(I2Name);
    iterCount=1;
    while(iterCount <=20)
    I2Cropped=imcrop(I2,[xmin,ymin,xmax-xmin,ymax-ymin]);

    probMap1=probMap(I2Cropped,H);

    

        sum1=0;

        sum2=0 ;

        sum3=0 ;

 

        for x=xmin: xmax    

            for y=ymin :ymax

                midx = (xmax - xmin)/2;
                midy = (ymax - ymin)/2;
                
                newx = x-midx;
                newy=y-midy;
                
             k=int16(x-xmin+1) ;

             l=int16(y-ymin+1) ;

             try

             sum1=sum1+ x*probMap1(l,k);

             sum2=sum2+ probMap1(l,k) ;

             sum3=sum3+ y* probMap1(l,k) ;

             catch err

                 disp(err);

             end

             end

        end

 

        xc=(sum1/sum2) ;

        yc=(sum3/sum2) ;

        

     

       

   

      %hold on ;

      %plot(xc, yc,'g+');

      w=  xwidth;%xmax-xmin ;

      h=  yheight;%ymax-ymin ;

      xmin=xc - (w)/2 ;

      ymin=yc - (h)/2 ;

      xmax= xc + (w)/2 ;

      ymax=yc + (h)/2 ;
      
      iterCount = iterCount+1;
    end
    figure ;

    imshow(I2Name);
    hold on;
    plot(xc, yc,'y+');
    plot([xmin,xmax,xmax,xmin,xmin], [ymin,ymin,ymax,ymax,ymin],'-g');
      
end
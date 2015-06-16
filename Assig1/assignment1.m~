B = [1 2; 3 4]; 
kernel=[5 6; 7 8];

size_kernelx=size(kernel,1);
size_kernely=size(kernel,2);

sizeBx=size(B,1);
sizeBy=size(B,2);

total_block_matrix=sizeBx ;
zeros_to_be_appended=size_kernely-1 ;
no_of_rows_of_blocked_matrix=sizeBx+zeros_to_be_appended ;
no_of_column_of_blocked_matrix=1+zeros_to_be_appended ;

for i=1:total_block_matrix    
   
    varname =zeros(no_of_rows_of_blocked_matrix,no_of_column_of_blocked_matrix);
    for j=1:sizeBy
     varname(j,1)= B(i,j);
    end  
    
    for m=2:no_of_rows_of_blocked_matrix
          for n=2:no_of_column_of_blocked_matrix
              varname(m,n)=varname(m-1,n-1);        
          end
    end
    blockedMatrixArray(i)=varname;
    disp(blockedMatrixArray(i));
end

no_of_zeros_in_final_matrix=size_kernelx-1 ;
final_matrix_no_of_rows= (total_block_matrix+ no_of_zeros_in_final_matrix)*no_of_rows_of_blocked_matrix ;
final_matrix_no_of_cols= (1+ no_of_zeros_in_final_matrix)*no_of_column_of_blocked_matrix;

final_matrix =zeros(final_matrix_no_of_rows,final_matrix_no_of_cols);
 
     































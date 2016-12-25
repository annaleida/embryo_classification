%clear all; close all;
%folderPath = 'C:\Temp\';
%dir 'C:\Temp\*.jpg'
listing = dir('C:\Temp\*.jpg')
ss = size(listing); nbr_im = ss(1);

for i=1:nbr_im
    filename = listing(i).name;
    newName = strcat('image_',strcat(num2str(i),'.jpg'));
    movefile(strcat(folderPath,filename),strcat(folderPath,newName));
    %delete(strcat(folderPath,filename));
end;

disp 'RenameImageFiles complete';
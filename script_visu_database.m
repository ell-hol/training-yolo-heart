clear 
close all
clc;
addpath(genpath('src'));

%-- Parameters
starting_id = 1;
nbPatient = 300;
path_to_png = 'data/';


%-- Loop over each patient
for its=1:nbPatient
    
    % Set proper patient id
    id = starting_id + its - 1;
    if id<10
        patientID = ['patient000',num2str(id)];
    else
        if id<100
            patientID = ['patient00',num2str(id)];
        else
            patientID = ['patient0',num2str(id)];
        end
    end
                        
    filenames{1} = [path_to_png,'img/',patientID,'_4CH_ED.png'];
    filenames{2} = [path_to_png,'ref/',patientID,'_4CH_ED_gt.png'];
    filenames{3} = [path_to_png,'img/',patientID,'_4CH_ES.png'];    
    filenames{4} = [path_to_png,'ref/',patientID,'_4CH_ES_gt.png'];
    

    %-- Display ED time
    bmode = imread(filenames{1});
    mask = imread(filenames{2});
    figure(1); imagesc(bmode); colormap('gray'); axis ij; axis image; colorbar;
    maskEndo = mask;
    maskEndo(maskEndo>85) = 0;
    maskEndo(maskEndo~=0) = 1;    
    hold on; contour(maskEndo,[1 1],'r','linewidth',2);
    maskEpi = mask;
    maskEpi(maskEpi>170) = 0;
    maskEpi(maskEpi~=0) = 1;    
    hold on; contour(maskEpi,[1 1],'g','linewidth',2);
    
    
    %-- Create bounding box
    [indI,indJ] = find(maskEpi~=0);
    i_min = min(indI);
    i_max = max(indI);
    j_min = min(indJ);
    j_max = max(indJ);

    
    %-- Add 10% of the main axis to the bounding box
    padI = round(0.1*(i_max-i_min));
    padJ = round(0.1*(j_max-j_min));        
    i_min = max(i_min-padI,1);
    i_max = min(i_max+padI,size(bmode,1));
    j_min = max(j_min-padJ,1);
    j_max = min(j_max+padJ,size(bmode,2));    
        
    
    bb = zeros(size(bmode));
    for i=i_min:i_max
        for j=j_min:j_max
            bb(i,j) = 1;
        end
    end
    hold on; contour(bb,[1 1],'b','linewidth',2);
    
    hold off;    
    title([patientID,'-4CH || Press enter to continue']);    
    pause();
    
    
end






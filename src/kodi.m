clear all; %Fshi të gjitha variablat nga memory.
pkg load image % Ngarko paketën "image" në Octave.

%Ngarko imazhin e quajtur "lena.tiff" dhe e konverto në formatin double.
img = im2double(imread("src/lena.tiff"));
img_size= size(img);

% Cakto dimensionet e secilit bllok si 2x2.
%block_size = [2 2];
% Kërko përdoruesit të jap një dimension të blloqeve
block_size = input("Shkruaj dimensionet e blloqeve: [rows cols]: ");
% Llogarit numrin e blloqeve në secilën drejtim.
num_blocks = floor(img_size(1:2) ./ block_size);

% Llogarit dimensionet e imazhit të pad-uar.
padded_size = num_blocks .* block_size;
% Krijo një matricë të re me vlera zero për të vendosur imazhin e pad-uar.
padded_img = zeros(padded_size(1), padded_size(2), size(img, 3));
% Vendos imazhin e vërtetë brenda matricës së pad-uar.
padded_img(1:size(img,1), 1:size(img,2), :) = img;

% Ndërro formën e matricës së pad-uar në forma bllokesh.
blocks = reshape(padded_img, block_size(1), num_blocks(1), block_size(2), num_blocks(2), 3);
%Ndërro renditjen e dimensioneve në matricën e blloqeve.
blocks = permute(blocks, [1 3 2 4 5]);
%Ndërro formën e matricës së blloqeve nga 4D në 2D.
blocks = reshape(blocks, block_size(1)*block_size(2), [], 3);

% Llogarit mesataren, devijimin standard, minimumin, maksimumin, medianën dhe energjinë e secilit bllok
means = mean(blocks); 
stds = std(blocks);
mins = min(blocks); 
maxs = max(blocks);
meds = median(blocks); 
energy = sum(blocks.^2); 

% Riformëso rezultatet në imazhe
mean_img = reshape(means, num_blocks(1), num_blocks(2), []);
std_img = reshape(stds, num_blocks(1), num_blocks(2), []);
min_img = reshape(mins, num_blocks(1), num_blocks(2), []);
max_img = reshape(maxs, num_blocks(1), num_blocks(2), []);
med_img = reshape(meds, num_blocks(1), num_blocks(2), []);
energy_img = reshape(energy, num_blocks(1), num_blocks(2), []);

% Paaraqitja e imazheve përfundimtare përmes figures dhe subplot
figure;
subplot(2,3,1);
imshow(imresize(mean_img, [256 256]));
title("Mean values");
subplot(2,3,2);
imshow(imresize(std_img, [256 256]));
title("Standard deviations");
subplot(2,3,3);
imshow(imresize(min_img, [256 256]));
title("Minimum values");
subplot(2,3,4);
imshow(imresize(max_img, [256 256]));
title("Maximum values");
subplot(2,3,5);
imshow(imresize(med_img, [256 256]));
title("Median values");
subplot(2,3,6);
imshow(imresize(energy_img, [256 256]));
title("Energy");
waitfor(gcf);





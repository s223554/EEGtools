function [ RawInBands ] = SpecSeperate( spec,fspec )
%SPECSEPERATE Summary of this function goes here
%   Input: Spectrum matrix. Output: Raw power in bands.
%RawInBands = zeros(size(spec,1),4,size(spec,3));
%spec : unit mv^2,
RawDelta = sum(spec(:,1<fspec&fspec<4,:),2);     
RawTheta = sum(spec(:,4<fspec&fspec<8,:),2);
RawAlpha = sum(spec(:,8<fspec&fspec<13,:),2);
RawBetaAndBeyond = sum(spec(:,13<fspec&fspec<32,:),2);
RawInBands = [RawDelta RawTheta RawAlpha RawBetaAndBeyond];
end


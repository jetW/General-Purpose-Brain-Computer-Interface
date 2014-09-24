%load Bandpass(01,90) Nothch(48,52) filtered EEG signals 
right_processed=load('2/rightBandpass0190Nothch4852');
left_processed=load('2/leftBandpass0190Nothch4852');
right_processed=right_processed.EEG.data;
left_processed=left_processed.EEG.data;

%take channel C3 and C4 from the signals
right_processed_C3=right_processed(5,:);
right_processed_C4=right_processed(6,:);
left_processed_C3=left_processed(5,:);
left_processed_C4=left_processed(6,:);

%chop the signal(the result signal contains the average of thecurrent second and the previos second)
left_C4_choped=chopSignal(left_processed_C4,500);
left_C3_choped=chopSignal(left_processed_C3,500);
right_C4_choped=chopSignal(right_processed_C4,500);
right_C3_choped=chopSignal(right_processed_C3,500);

%allocate space for the features vectors
right_C4_features=zeros(127,500);
right_C3_features=zeros(127,500);
left_C4_features=zeros(127,500);
left_C3_features=zeros(127,500);

%get the coefficiants of the Multi-level 1-D wavelet decomposition using
%the forth order Daubechies wavelet
for i=1:size(right_C4_choped,1)
    right_C4_features(i,:) = abs(fft(right_C4_choped(i,:)));
    right_C3_features(i,:) = abs(fft(right_C3_choped(i,:)));
    left_C4_features(i,:) = abs(fft(left_C4_choped(i,:)));
    left_C3_features(i,:) = abs(fft(left_C3_choped(i,:)));
end
right_C4_features=right_C4_features';
right_C3_features=right_C3_features';
left_C4_features=left_C4_features';
left_C3_features=left_C3_features';


%avarage the features vectors of C3, C4 to reduse the computation time
right_features=(right_C4_features+right_C3_features)/2;
left_features=(left_C4_features+left_C3_features)/2;

%setup the input and target vectors
input=[right_features left_features];
output=[zeros(1,127) ones(1,127)];
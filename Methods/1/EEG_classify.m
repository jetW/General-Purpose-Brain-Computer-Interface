%load Bandpass(08,12) filtered EEG signals (alfa and beta)
right_processed=load('1/rightBandpass0812');
left_processed=load('1/leftBandpass0812');
right_processed=right_processed.EEG.data;
left_processed=left_processed.EEG.data;

%take channel C3 and C4 from the signals
right_processed_C3=right_processed(5,:);
right_processed_C4=right_processed(6,:);
left_processed_C3=left_processed(5,:);
left_processed_C4=left_processed(6,:);

%chop the signal(the result signal contains the average of the current second and the previos second)
left_C4_choped=chopSignal(left_processed_C4,500);
left_C3_choped=chopSignal(left_processed_C3,500);
right_C4_choped=chopSignal(right_processed_C4,500);
right_C3_choped=chopSignal(right_processed_C3,500);

%Use the siganls as features
right_C4_features=right_C4_choped';
right_C3_features=right_C3_choped';
left_C4_features=left_C4_choped';
left_C3_features=left_C3_choped';

%avarage the features vectors of C3, C4 to reduse the computation time
right_features=(right_C4_features+right_C3_features)/2;
left_features=(left_C4_features+left_C3_features)/2;

%setup the input and target vectors
input=[right_features left_features];
output=[zeros(1,127) ones(1,127)];
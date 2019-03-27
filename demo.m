%{
%%
[meteotrin,meteotrtar,meteotein,meteotetar] = prep_meteo(train_days,test_days);

meteonet = train(meteotrin,meteotrtar);

[meteomae,meteormse] = test(meteonet,meteotein,meteotetar);

%%
[ar1trin,ar1trtar,ar1tein,ar1tetar] = prep_ar1(train_days,test_days);

ar1net = train(ar1trin,ar1trtar);

[ar1mae,ar1rmse] = test(ar1net,ar1tein,ar1tetar);

%%
[ar10trin,ar10trtar,ar10tein,ar10tetar] = prep_ar10(train_days,test_days);

ar10net = train(ar10trin,ar10trtar);

[ar10mae,ar10rmse] = test(ar10net,ar10tein,ar10tetar);

%%
[arima10trin,arima10trtar,arima10tein,arima10tetar] = prep_arima10(train_days,test_days);

arima10net = train(arima10trin,arima10trtar);

[arima10mae,arima10rmse] = test(arima10net,arima10tein,arima10tetar);

%%
[bintrin,bintrtar,bintein,bintetar] = prep_bin(train_days,test_days);

binnet = train(bintrin,bintrtar);

[binmae,binrmse] = test(binnet,bintein,bintetar);
%}
%%
[diff2trin,diff2trtar,diff2tein,diff2tetar] = prep_diff2(train_days,test_days);

diff2net = train(diff2trin,diff2trtar);

[diff2mae,diff2rmse] = test(diff2net,diff2tein,diff2tetar);
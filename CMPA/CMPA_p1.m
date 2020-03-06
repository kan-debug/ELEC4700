close all
clearvars

Is = 0.01e-12;
Ib = 0.1e-12;
Vb = 1.3;
Gp = 0.1;

V = linspace(-1.95,0.7,201);
I = Is* (exp(1.2/0.025*V)-1) + Gp * V - Ib*(exp(-1.2/0.025*(V+Vb))-1);
I_randn = I + 0.2*randn(1,numel(I)).*I;

figure(1)

subplot(3,1,1),plot(V,I_randn);
hold on
subplot(3,1,2),plot(V,I_randn);
hold on
subplot(3,1,3),plot(V,I_randn);
hold on

[fit4_poly,fit8_poly] = polyfit_p1(V,I_randn,4,8);
subplot(3,1,1),plot(V,fit4_poly);
subplot(3,1,1),plot(V,fit8_poly);

[I_fit_2, I_fit_3, I_fit_all] = nonlin_fit(V, I_randn);
subplot(3,1,2),plot(V,I_fit_2);
subplot(3,1,2),plot(V,I_fit_3);
subplot(3,1,2),plot(V,I_fit_all);

%log scale
figure(2)
subplot(3,1,1),semilogy(V,abs(I_randn));
hold on
subplot(3,1,2),semilogy(V,abs(I_randn));
hold on
subplot(3,1,3),semilogy(V,abs(I_randn));
hold on

[fit4_log_poly,fit8_log_poly] = polyfit_p1(V,I_randn,4 ,8);
subplot(3,1,1),semilogy(V,abs(fit4_log_poly));
subplot(3,1,1),semilogy(V,abs(fit8_log_poly));

[I_fit_2_log, I_fit_3_log, I_fit_all_log] = nonlin_fit(V, I_randn);
subplot(3,1,2),semilogy(V,abs(I_fit_2));
subplot(3,1,2),semilogy(V,abs(I_fit_3));
subplot(3,1,2),semilogy(V,abs(I_fit_all));

% [fit4_log_poly,fit4_log_randn_poly] = polyfit_p1(V,log(abs(I)), log(abs(I_randn)),4);
% subplot(3,1,1),plot(V,fit4_log_poly);
% subplot(3,1,2),plot(V,fit4_log_randn_poly);

inputs = V;
targets = I_randn;
hiddenLayerSize = 10;
net = fitnet(hiddenLayerSize);
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;
[net,tr] = train(net,inputs,targets);
outputs = net(inputs);
errors = gsubtract(outputs,targets);
performance = perform(net,targets,outputs)
view(net)
Inn = outputs
figure(1)
subplot(3,1,3),plot(V,Inn);
figure(2)
subplot(3,1,3),semilogy(V,abs(Inn));


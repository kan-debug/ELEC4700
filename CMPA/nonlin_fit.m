function [fit_2, fit_3, fit_all] = nonlin_fit(V, I_randn)
fo_all = fittype('A.*(exp(1.2*x/25e-3)-1) + B.*x - C*(exp(1.2*(-(x+D))/25e-3)-1)');
ff = fit(V',I_randn',fo_all);
fit_all = ff(V);

fo_2 = fittype('A.*(exp(1.2*x/25e-3)-1) + 0.1.*x - C*(exp(1.2*(-(x+1.3))/25e-3)-1)');
ff = fit(V',I_randn',fo_2);
fit_2 = ff(V);

fo_3 = fittype('A.*(exp(1.2*x/25e-3)-1) + B.*x - C*(exp(1.2*(-(x+1.3))/25e-3)-1)');
ff = fit(V',I_randn',fo_3);
fit_3 = ff(V);

end
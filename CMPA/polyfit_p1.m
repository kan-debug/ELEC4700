function [fit_1, fit_2] = polyfit_p1(V, I_randn,order,order2)

poly_coefficient = polyfit(V,I_randn,order);
poly_randn_coefficient = polyfit(V,I_randn,order2);
fit_1 = polyval(poly_coefficient,V);
fit_2 = polyval(poly_randn_coefficient,V);


end
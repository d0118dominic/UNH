;;;;
;
;;;
;Calculate mechanical and em energy densities 

probe = '1'

sc = 'mms' + probe

;timespan,'2017-07-11/22:32:00',1 , /Minute
;timespan,'2017-07-11/22:30:00',7 , /minute
;timespan,'2017-06-17/20:23:30',1 , /minute
;timespan,'2019-04-20/15:32:00',30 , /Second


;mms_load_fpi,data_rate = 'brst',probes = probe,/time_clip
;mms_load_edp,level = 'l2',data_rate = 'brst',probes = probe, /time_clip
;mms_load_fgm, level = 'l2',data_rate = 'brst',probes = probe,/time_clip

get_data, sc + '_des_bulkv_gse_brst', DATA = vel_e

t = vel_e.x
N = n_elements(t)

sc  = 'mms' + probe
mu0 = 1.2566370e-06  ;m kg / C^2
e0 = 8.85e-12    ;C/N(m^2)
m_e = 9.1093836e-31 ; kg
m_i = 1.6726219e-27 ; kg

get_data, sc + '_edp_dce_gse_brst_l2', data = E
get_data, sc + '_fgm_b_gse_brst_l2_btot', data = B

get_data, sc + '_des_numberdensity_brst', DATA = n_e
get_data, sc + '_dis_numberdensity_brst', DATA = n_i

get_data, sc + '_des_prestensor_gse_brst', DATA = Pe_tens
get_data, sc + '_dis_prestensor_gse_brst', DATA = Pi_tens


get_data, sc + '_des_bulkv_gse_brst', DATA = vel_e
get_data, sc + '_dis_bulkv_gse_brst', DATA = vel_i

get_data, sc + '_des_temptensor_gse_brst', DATA = Te_tens
get_data, sc + '_dis_temptensor_gse_brst', DATA = Ti_tens

Te = (Te_tens.y[*,0,0] + Te_tens.y[*,1,1] + Te_tens.y[*,2,2])/3
Ti = (Ti_tens.y[*,0,0] + Ti_tens.y[*,1,1] + Ti_tens.y[*,2,2])/3
Pe = (Pe_tens.y[*,0,0] + Pe_tens.y[*,1,1] + Pe_tens.y[*,2,2])/3
Pi = (Pi_tens.y[*,0,0] + Pi_tens.y[*,1,1] + Pi_tens.y[*,2,2])/3

Te = {x: Te_tens.x, y: Te}
Ti = {x: Ti_tens.x, y: Ti}
Pe = {x: Pe_tens.x, y: Pe}
Pi = {x: Pi_tens.x, y: Pi}



Pe = (Pe_tens.y[*,0,0] + Pe_tens.y[*,1,1] + Pe_tens.y[*,2,2])/2
Pi = (Pi_tens.y[*,0,0] + Pi_tens.y[*,1,1] + Pi_tens.y[*,2,2])/2

Pe = {x:Pe_tens.x, y:Pe}
Pi = {x:Pi_tens.x, y:Pi}

;stop
E = 1e-3*interp(E.y,E.x,t)
B = 1e-9*interp(B.y,B.x,t)
n_e = 1e6*interp(n_e.y,n_e.x,t)
n_i = 1e6*interp(n_i.y,n_i.x,t)
vel_e = 1000*interp(vel_e.y,vel_e.x,t)
vel_i = 1000*interp(vel_i.y,vel_i.x,t)
Pi = 1e-9*interp(Pi.y, Pi.x, t)
Pe = 1e-9*interp(Pe.y, Pe.x, t)
Ti = 1.6e-19*interp(Ti.y, Ti.x, t)
Te = 1.6e-19*interp(Te.y, Te.x, t)



M1 = fltarr(N)
M2 = fltarr(N)
EB1 = fltarr(N)
EB2 = fltarr(N)
UM = fltarr(N)
UEB = fltarr(N)

M1 = Te + Ti 
M2 = 0.5 * ((m_e*n_e*(vel_e)^2) + (m_i*n_i*(vel_i)^2))
UM = M1 + M2



EB1 = 0.5 * ((B^2)/mu0)
EB2 = 0.5 * e0*(E[*,0]^2 + E[*,1]^2 + E[*,2]^2)
UEB = EB1 + EB2


store_data, 'EnDensities', data = {x:t, y: [[UM],[UEB]]}
options, 'EnDensities', 'colors', ['k','b']
options, 'EnDensities', 'labels', ['Mechanical', 'Electromagnetic']
options, 'EnDensities', 'labflag', 1
options, 'EnDensities', 'ylog', 1







end







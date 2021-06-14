;;FxvBx
;
;;;FXvBz;;;;
;
get_data, 'K_e_mms1', data = ke1
get_data, 'K_i_mms1', data = ki1
get_data, 'K_e_mms2', data = ke2
get_data, 'K_i_mms2', data = ki2
get_data, 'K_e_mms3', data = ke3
get_data, 'K_i_mms3', data = ki3
get_data, 'K_e_mms4', data = ke4
get_data, 'K_i_mms4', data = ki4
get_data, 'H_e_mms1', data = he1
get_data, 'H_i_mms1', data = hi1
get_data, 'H_e_mms2', data = he2
get_data, 'H_i_mms2', data = hi2
get_data, 'H_e_mms3', data = he3
get_data, 'H_i_mms3', data = hi3
get_data, 'H_e_mms4', data = he4
get_data, 'H_i_mms4', data = hi4
get_data, 'S_Hall_mms1', data = sh1
get_data, 'S_MHD_mms1', data = sm1
get_data, 'S_Hall_mms2', data = sh2
get_data, 'S_MHD_mms2', data = sm2
get_data, 'S_Hall_mms3', data = sh3
get_data, 'S_MHD_mms3', data = sm3
get_data, 'S_Hall_mms4', data = sh4
get_data, 'S_MHD_mms4', data = sm4

a = fltarr(1)
a = 2

if (a eq 1) then begin
  get_data, 'Ke_int_mms1', data = ke1
  get_data, 'Ki_int_mms1', data = ki1
  get_data, 'Ke_int_mms2', data = ke2
  get_data, 'Ki_int_mms2', data = ki2
  get_data, 'Ke_int_mms3', data = ke3
  get_data, 'Ki_int_mms3', data = ki3
  get_data, 'Ke_int_mms4', data = ke4
  get_data, 'Ki_int_mms4', data = ki4
  get_data, 'He_int_mms1', data = he1
  get_data, 'Hi_int_mms1', data = hi1
  get_data, 'He_int_mms2', data = he2
  get_data, 'Hi_int_mms2', data = hi2
  get_data, 'He_int_mms3', data = he3
  get_data, 'Hi_int_mms3', data = hi3
  get_data, 'He_int_mms4', data = he4
  get_data, 'Hi_int_mms4', data = hi4
  get_data, 'S_int_mms1', data = sh1
  get_data, 'S_int_mms2', data = sh2
  get_data, 'S_int_mms3', data = sh3
  get_data, 'S_int_mms4', data = sh4
endif




;;;; Bz vs Kz ;;;;
get_data, 'mms1_fgm_b_gse_brst_l2_bvec', data = b1
get_data, 'mms2_fgm_b_gse_brst_l2_bvec', data = b2
get_data, 'mms3_fgm_b_gse_brst_l2_bvec', data = b3
get_data, 'mms4_fgm_b_gse_brst_l2_bvec', data = b4
;; ions ;;
b1 = interp(b1.y,b1.x,ki1.x)
b2 = interp(b2.y,b2.x,ki2.x)
b3 = interp(b3.y,b3.x,ki3.x)
b4 = interp(b4.y,b4.x,ki4.x)

ki1 = plot(b1[*,0], abs(ki1.y),linestyle = ' ', symbol = '*',/ylog, ytitle = 'Ki', yrange = [1e-14,1],xrange = [-20,20],name = 'MMS1',xtitle = 'Bx (nT)')
ki2 = plot(b2[*,0], abs(ki2.y),/overplot, color = 'black', linestyle = ' ', symbol = '*', name = 'MMS2')
ki3 = plot(b3[*,0], abs(ki3.y),/overplot, color = 'black',linestyle = ' ', symbol = '*',name = 'MMS3')
ki4 = plot(b4[*,0], abs(ki4.y),/overplot, color = 'black',linestyle = ' ', symbol = '*',name = 'MMS4')
leg = legend(target = [ki1,ki2,ki3,ki4], position = [-10,10000000],/data, /AUTO_TEXT_COLOR, sample_magnitude = 0, sample_width = 0)
;stop

get_data, 'mms1_fgm_b_gse_brst_l2_bvec', data = b1
get_data, 'mms2_fgm_b_gse_brst_l2_bvec', data = b2
get_data, 'mms3_fgm_b_gse_brst_l2_bvec', data = b3
get_data, 'mms4_fgm_b_gse_brst_l2_bvec', data = b4

;; electrons ;;
b1 = interp(b1.y,b1.x,ke1.x)
b2 = interp(b2.y,b2.x,ke2.x)
b3 = interp(b3.y,b3.x,ke3.x)
b4 = interp(b4.y,b4.x,ke4.x)

ke1 = plot(b1[*,0], abs(ke1.y),linestyle = ' ', symbol = '*',/ylog, ytitle = 'Ke', yrange = [1e-15,1],xrange = [-20,20],name = 'MMS1',xtitle = 'Bx (nT)')
ke2 = plot(b2[*,0], abs(ke2.y),/overplot, color = 'black', linestyle = ' ', symbol = '*', name = 'MMS2')
ke3 = plot(b3[*,0], abs(ke3.y),/overplot, color = 'black',linestyle = ' ', symbol = '*', name = 'MMS3')
ke4 = plot(b4[*,0], abs(ke4.y),/overplot, color = 'black',linestyle = ' ', symbol = '*', name = 'MMS4')
leg = legend(target = [ke1,ke2,ke3,ke4], position = [-10,10000000],/data, /AUTO_TEXT_COLOR, sample_magnitude = 0, sample_width = 0)
;stop



;;;; Bz vs Hz ;;;
get_data, 'mms1_fgm_b_gse_brst_l2_bvec', data = b1
get_data, 'mms2_fgm_b_gse_brst_l2_bvec', data = b2
get_data, 'mms3_fgm_b_gse_brst_l2_bvec', data = b3
get_data, 'mms4_fgm_b_gse_brst_l2_bvec', data = b4


;; ions ;;
b1 = interp(b1.y,b1.x,hi1.x)
b2 = interp(b2.y,b2.x,hi2.x)
b3 = interp(b3.y,b3.x,hi3.x)
b4 = interp(b4.y,b4.x,hi4.x)


hi = plot(b1[*,0], abs(hi1.y),linestyle = ' ', symbol = '.',/ylog, ytitle = 'Hi',xrange = [-20,20], yrange = [1e-7,1],xtitle = 'Bx (nT)')
hi = plot(b2[*,0], abs(hi2.y),/overplot, color = 'black', linestyle = ' ', symbol = '*')
hi = plot(b3[*,0], abs(hi3.y),/overplot, color = 'black',linestyle = ' ', symbol = '*')
hi = plot(b4[*,0], abs(hi4.y),/overplot, color = 'black',linestyle = ' ', symbol = '*')
;stop

get_data, 'mms1_fgm_b_gse_brst_l2_bvec', data = b1
get_data, 'mms2_fgm_b_gse_brst_l2_bvec', data = b2
get_data, 'mms3_fgm_b_gse_brst_l2_bvec', data = b3
get_data, 'mms4_fgm_b_gse_brst_l2_bvec', data = b4

;; electrons ;;
b1 = interp(b1.y,b1.x,he1.x)
b2 = interp(b2.y,b2.x,he2.x)
b3 = interp(b3.y,b3.x,he3.x)
b4 = interp(b4.y,b4.x,he4.x)


he = plot(b1[*,0], abs(he1.y),linestyle = ' ', symbol = '.',/ylog, ytitle = 'He', xtitle = 'Bx (nT)',xrange = [-20,20], yrange = [1e-7,1])
he = plot(b2[*,0], abs(he2.y),/overplot, color = 'black', linestyle = ' ', symbol = '*')
he = plot(b3[*,0], abs(he3.y),/overplot, color = 'black',linestyle = ' ', symbol = '*')
he = plot(b4[*,0], abs(he4.y),/overplot, color = 'black',linestyle = ' ', symbol = '*')

stop


;;;; Vz vs Sz ;;;;
get_data, 'mms1_fgm_b_gse_brst_l2_bvec', data = b1
get_data, 'mms2_fgm_b_gse_brst_l2_bvec', data = b2
get_data, 'mms3_fgm_b_gse_brst_l2_bvec', data = b3
get_data, 'mms4_fgm_b_gse_brst_l2_bvec', data = b4

;; Total S ;;

b1 = interp(b1.y,b1.x,sh1.x)
b2 = interp(b2.y,b2.x,sh2.x)
b3 = interp(b3.y,b3.x,sh3.x)
b4 = interp(b4.y,b4.x,sh4.x)

sh = plot(b1[*,0], abs(sh1.y),linestyle = ' ', symbol = '*',/ylog, ytitle = 'S', yrange = [1e-6,1],xrange = [-20,20],xtitle = 'Bx (nT)')
sh = plot(b2[*,0], abs(sh2.y),/overplot, color = 'black', linestyle = ' ', symbol = '*')
sh = plot(b3[*,0], abs(sh3.y),/overplot, color = 'black',linestyle = ' ', symbol = '*')
sh = plot(b4[*,0], abs(sh4.y),/overplot, color = 'black',linestyle = ' ', symbol = '*')

;stop

get_data, 'mms1_fgm_b_gse_brst_l2_bvec', data = b1
get_data, 'mms2_fgm_b_gse_brst_l2_bvec', data = b2
get_data, 'mms3_fgm_b_gse_brst_l2_bvec', data = b3
get_data, 'mms4_fgm_b_gse_brst_l2_bvec', data = b4



;; MHD component ;;
;b1 = interp(b1.y,b1.x,sm1.x)
;b2 = interp(b2.y,b2.x,sm2.x)
;b3 = interp(b3.y,b3.x,sm3.x)
;b4 = interp(b4.y,b4.x,sm4.x)
;sm = plot(b1[*,2], abs(sm1.y),linestyle = ' ', symbol = '*',/ylog, ytitle = 'S_MHD',yrange = [1e-6,1e-3],xtitle = 'Bz (nT)')
;sm = plot(b2[*,2], abs(sm2.y),/overplot, color = 'blue', linestyle = ' ', symbol = '*')
;sm = plot(b3[*,2], abs(sm3.y),/overplot, color = 'green',linestyle = ' ', symbol = '*')
;sm = plot(b4[*,2], abs(sm4.y),/overplot, color = 'red',linestyle = ' ', symbol = '*')


end
SELECT p.objID, p.dered_u, p.dered_g, p.dered_r, p.dered_i, p.dered_z, 

  p.petroR50_u, p.petroR90_u, p.mE1_u, p.mE2_u, p.deVAB_u, p.expAB_u, p.lnLExp_u, p.lnLDeV_u,
  p.lnLStar_u, p.mRrCc_u, p.mCr4_u, p.texture_u,
  
  p.petroR50_r, p.petroR90_r, p.mE1_r, p.mE2_r, p.deVAB_r, p.expAB_r, p.lnLExp_r, p.lnLDeV_r,
  p.lnLStar_r, p.mRrCc_r, p.mCr4_r, p.texture_r,
  
  m.p_el, m.p_dk, m.p_mg, m.p_cs from DR7..PhotoObjAll p, Votos m   
  
WHERE p.objID=m.dr7objid and  (m.p_el > 0.8 or m.p_dk > 0.8 or m.p_cs > 0.8) and m.p_mg < 0.8 and p.dered_u != -9999 and p.dered_g != -9999 and p.dered_r != -9999 
and p.dered_i != -9999 and p.dered_z != -9999 and 

p.petroR50_u != -9999 and p.petroR90_u != -9999 and p.mE1_u != -9999 and p.mE2_u != -9999 and p.deVAB_u != -9999 and p.expAB_u != -9999 and p.lnLExp_u != -9999 and p.lnLDeV_u != -9999 and p.lnLStar_u != -9999 and 
p.mRrCc_u != -9999 and p.mCr4_u != -9999 and p.texture_u != -9999 and
   
p.petroR50_i != -9999 and p.petroR90_i != -9999 and p.mE1_i != -9999 and p.mE2_i != -9999 and p.deVAB_i != -9999 and p.expAB_i != -9999 and p.lnLExp_i != -9999 and p.lnLDeV_i != -9999 and p.lnLStar_i != -9999 and 
p.mRrCc_i != -9999 and p.mCr4_i != -9999 and p.texture_i != -9999 and
  
p.petroR50_r != -9999 and p.petroR90_r != -9999 and p.mE1_r != -9999 and p.mE2_r != -9999 and p.deVAB_r != -9999 and p.expAB_r != -9999 and p.lnLExp_r != -9999 and p.lnLDeV_r != -9999 and p.lnLStar_r != -9999 and 
p.mRrCc_r != -9999 and p.mCr4_r != -9999 and p.texture_r != -9999;
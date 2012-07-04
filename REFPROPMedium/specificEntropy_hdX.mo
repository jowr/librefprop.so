within MediaTwoPhaseMixture.REFPROPMedium;
function specificEntropy_hdX
  extends Modelica.Icons.Function;
    input Modelica.SIunits.SpecificEnthalpy h;
    input Modelica.SIunits.Density d;
  input MassFraction X[:]=reference_X "mass fraction m_NaCl/m_Sol";
  input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  output Modelica.SIunits.SpecificEntropy s;
algorithm
  if debugmode then
    Modelica.Utilities.Streams.print("Running specificEntropy_hdX("+String(h)+","+String(d)+",X)");
  end if;
    s:=getProp_REFPROP_check("s", "hd",h,d,X,phase);
  annotation(LateInline=true,inverse(d=density_hsX(h,s,X,phase),
                                     h=specificEnthalpy_dsX(d,s,X,phase)));
end specificEntropy_hdX;

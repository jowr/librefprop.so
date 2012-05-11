within MediaTwoPhaseMixture.REFPROPMediumPureSubstance;
function setState "Calculates medium properties"
  extends partialREFPROP;
  input String statevars;
  input Real statevar1;
  input Real statevar2;
  input Modelica.SIunits.MassFraction X[:]=reference_X "Mass fractions";
  input FixedPhase phase "2 for two-phase, 1 for one-phase, 0 if not known";
  input String fluidnames;
  output ThermodynamicState state "thermodynamic state record";
//  Real[:] props=getProps_REFPROP_check(statevars, fluidnames,statevar1, statevar2, X, phase);
/*protected 
  Real[16+2*nX] props;
  String errormsg=StrJoin(fill("xxxx",64),"") 
    "Allocating memory, string will be written by C function";*/

algorithm
  assert(size(X,1)>0,"The mass fraction vector must have at least 1 element.");
  getProp_REFPROP("",statevars,fluidnames,props,statevar1,statevar2,X,phase,errormsg);
  assert(props[1]==0,"Error in REFPROP wrapper function: "+errormsg +"\n");
/*  If q = 990 Then Modelica.Utilities.Streams.print(msg+String(z)) end if;

  If q = 998 Then Quality = Trim2("Superheated vapor with T>Tc")
  If q = 999 Then Quality = Trim2("Supercritical state (T>Tc, p>pc)")
  If q = -998 Then Quality = Trim2("Subcooled liquid with p>pc")*/
  state := ThermodynamicState(  p= props[2],
                              T= props[3],
                              X= X,
                              MM= props[4],
                              d=props[5],
                              d_l=props[6],
                              d_g=props[7],
                              q=min(max(props[8],0),1),
                              u=props[9],
                              h=props[10],
                              s=props[11],
                              cv=props[12],
                              cp=props[13],
                              c=props[14],
                              MM_l=props[15],
                              MM_g=props[16],
                              X_l=props[17:16+nX],
                              X_g=props[17+nX:16+2*nX],
                              phase=0);

end setState;

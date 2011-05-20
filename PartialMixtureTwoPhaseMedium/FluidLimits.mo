within MediaTwoPhaseMixture.PartialMixtureTwoPhaseMedium;
record FluidLimits "validity limits for fluid model"
  extends Modelica.Icons.Record;
  Temperature TMIN "minimum temperature";
  Temperature TMAX "maximum temperature";
  Density DMIN "minimum density";
  Density DMAX "maximum density";
  AbsolutePressure PMIN "minimum pressure";
  AbsolutePressure PMAX "maximum pressure";
  SpecificEnthalpy HMIN "minimum enthalpy";
  SpecificEnthalpy HMAX "maximum enthalpy";
  SpecificEntropy SMIN "minimum entropy";
  SpecificEntropy SMAX "maximum entropy";
  annotation(Documentation(
      info="<html>
          <p>The minimum pressure mostly applies to the liquid state only.
          The minimum density is also arbitrary, but is reasonable for techical
          applications to limit iterations in non-linear systems. The limits in
          enthalpy and entropy are used as safeguards in inverse iterations.</p>
          </html>"));
end FluidLimits;

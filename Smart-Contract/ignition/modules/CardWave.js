const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");

module.exports = buildModule("CardWaveModule", (m) => {
  const CardWave = m.contract("CardWave");

  return { CardWave };
});

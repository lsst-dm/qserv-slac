SELECT
`objectId`,
`coord_dec`,
`coord_ra`,
`deblend_nChild`,
`deblend_skipped`,
`detect_fromBlend`,
`detect_isDeblendedModelSource`,
`detect_isDeblendedSource`,
`detect_isIsolated`,
`detect_isPatchInner`,
`detect_isPrimary`,
`detect_isTractInner`,
`footprintArea`,
`merge_peak_sky`,
`parentObjectId`,
`patch`,
`refBand`,
`refExtendedness`,
`refFwhm`,
`shape_flag`,
`shape_xx`,
`shape_xy`,
`shape_yy`,
`sky_object`,
`skymap`,
`tract`,
`x`,
`xErr`,
`xy_flag`,
`y`,
`yErr`,
`g_ap03Flux`,
`g_ap03FluxErr`,
`g_ap03Flux_flag`,
`g_ap06Flux`,
`g_ap06FluxErr`,
`g_ap06Flux_flag`,
`g_ap09Flux`,
`g_ap09FluxErr`,
`g_ap09Flux_flag`,
`g_ap12Flux`,
`g_ap12FluxErr`,
`g_ap12Flux_flag`,
`g_ap17Flux`,
`g_ap17FluxErr`,
`g_ap17Flux_flag`,
`g_ap25Flux`,
`g_ap25FluxErr`,
`g_ap25Flux_flag`,
`g_ap35Flux`,
`g_ap35FluxErr`,
`g_ap35Flux_flag`,
`g_ap50Flux`,
`g_ap50FluxErr`,
`g_ap50Flux_flag`,
`g_ap70Flux`,
`g_ap70FluxErr`,
`g_ap70Flux_flag`,
`g_apFlux_flag`,
`g_apFlux_flag_apertureTruncated`,
`g_apFlux_flag_sincCoeffsTruncated`,
`g_bdChi2`,
`g_bdE1`,
`g_bdE2`,
`g_bdFluxB`,
`g_bdFluxBErr`,
`g_bdFluxD`,
`g_bdFluxDErr`,
`g_bdReB`,
`g_bdReD`,
`g_blendedness`,
`g_blendedness_flag`,
`g_cModelFlux`,
`g_cModelFluxErr`,
`g_cModelFlux_inner`,
`g_cModel_flag`,
`g_cModel_flag_apCorr`,
`g_calibFlux`,
`g_calibFluxErr`,
`g_calibFlux_flag`,
`g_calibFlux_flag_apertureTruncated`,
`g_calibFlux_flag_sincCoeffsTruncated`,
`g_calib_astrometry_used`,
`g_calib_photometry_reserved`,
`g_calib_photometry_used`,
`g_calib_psf_candidate`,
`g_calib_psf_reserved`,
`g_calib_psf_used`,
`g_centroid_flag`,
`g_centroid_x`,
`g_centroid_xErr`,
`g_centroid_y`,
`g_centroid_yErr`,
`g_decl`,
`g_extendedness`,
`g_extendedness_flag`,
`g_free_cModelFlux`,
`g_free_cModelFluxErr`,
`g_free_cModelFlux_flag`,
`g_free_cModelFlux_inner`,
`g_free_psfFlux`,
`g_free_psfFluxErr`,
`g_free_psfFlux_flag`,
`g_fwhm`,
`g_gaap0p5Flux`,
`g_gaap0p5FluxErr`,
`g_gaap0p5Flux_flag_bigPsf`,
`g_gaap0p7Flux`,
`g_gaap0p7FluxErr`,
`g_gaap0p7Flux_flag_bigPsf`,
`g_gaap1p0Flux`,
`g_gaap1p0FluxErr`,
`g_gaap1p0Flux_flag_bigPsf`,
`g_gaap1p5Flux`,
`g_gaap1p5FluxErr`,
`g_gaap1p5Flux_flag_bigPsf`,
`g_gaap2p5Flux`,
`g_gaap2p5FluxErr`,
`g_gaap2p5Flux_flag_bigPsf`,
`g_gaap3p0Flux`,
`g_gaap3p0FluxErr`,
`g_gaap3p0Flux_flag_bigPsf`,
`g_gaapFlux_flag`,
`g_gaapFlux_flag_edge`,
`g_gaapFlux_flag_gaussianization`,
`g_gaapOptimalFlux`,
`g_gaapOptimalFluxErr`,
`g_gaapOptimalFlux_flag_bigPsf`,
`g_gaapPsfFlux`,
`g_gaapPsfFluxErr`,
`g_hsmShapeRegauss_e1`,
`g_hsmShapeRegauss_e2`,
`g_hsmShapeRegauss_flag`,
`g_hsmShapeRegauss_sigma`,
`g_iDebiasedPSF_flag`,
`g_iPSF_flag`,
`g_iRound_flag`,
`g_i_flag`,
`g_inputCount`,
`g_inputCount_flag`,
`g_inputCount_flag_noInputs`,
`g_ixx`,
`g_ixxDebiasedPSF`,
`g_ixxPSF`,
`g_ixxRound`,
`g_ixy`,
`g_ixyDebiasedPSF`,
`g_ixyPSF`,
`g_ixyRound`,
`g_iyy`,
`g_iyyDebiasedPSF`,
`g_iyyPSF`,
`g_iyyRound`,
`g_kronFlux`,
`g_kronFluxErr`,
`g_kronFlux_flag`,
`g_kronFlux_flag_bad_radius`,
`g_kronFlux_flag_bad_shape`,
`g_kronFlux_flag_bad_shape_no_psf`,
`g_kronFlux_flag_edge`,
`g_kronFlux_flag_no_fallback_radius`,
`g_kronFlux_flag_no_minimum_radius`,
`g_kronFlux_flag_small_radius`,
`g_kronFlux_flag_used_minimum_radius`,
`g_kronFlux_flag_used_psf_radius`,
`g_kronRad`,
`g_pixelFlags_bad`,
`g_pixelFlags_clipped`,
`g_pixelFlags_clippedCenter`,
`g_pixelFlags_cr`,
`g_pixelFlags_crCenter`,
`g_pixelFlags_edge`,
`g_pixelFlags_inexact_psf`,
`g_pixelFlags_inexact_psfCenter`,
`g_pixelFlags_interpolated`,
`g_pixelFlags_interpolatedCenter`,
`g_pixelFlags_offimage`,
`g_pixelFlags_saturated`,
`g_pixelFlags_saturatedCenter`,
`g_pixelFlags_sensor_edge`,
`g_pixelFlags_sensor_edgeCenter`,
`g_pixelFlags_suspect`,
`g_pixelFlags_suspectCenter`,
`g_psfFlux`,
`g_psfFluxErr`,
`g_psfFlux_area`,
`g_psfFlux_flag`,
`g_psfFlux_flag_apCorr`,
`g_psfFlux_flag_edge`,
`g_psfFlux_flag_noGoodPixels`,
`g_ra`,
`i_ap03Flux`,
`i_ap03FluxErr`,
`i_ap03Flux_flag`,
`i_ap06Flux`,
`i_ap06FluxErr`,
`i_ap06Flux_flag`,
`i_ap09Flux`,
`i_ap09FluxErr`,
`i_ap09Flux_flag`,
`i_ap12Flux`,
`i_ap12FluxErr`,
`i_ap12Flux_flag`,
`i_ap17Flux`,
`i_ap17FluxErr`,
`i_ap17Flux_flag`,
`i_ap25Flux`,
`i_ap25FluxErr`,
`i_ap25Flux_flag`,
`i_ap35Flux`,
`i_ap35FluxErr`,
`i_ap35Flux_flag`,
`i_ap50Flux`,
`i_ap50FluxErr`,
`i_ap50Flux_flag`,
`i_ap70Flux`,
`i_ap70FluxErr`,
`i_ap70Flux_flag`,
`i_apFlux_flag`,
`i_apFlux_flag_apertureTruncated`,
`i_apFlux_flag_sincCoeffsTruncated`,
`i_bdChi2`,
`i_bdE1`,
`i_bdE2`,
`i_bdFluxB`,
`i_bdFluxBErr`,
`i_bdFluxD`,
`i_bdFluxDErr`,
`i_bdReB`,
`i_bdReD`,
`i_blendedness`,
`i_blendedness_flag`,
`i_cModelFlux`,
`i_cModelFluxErr`,
`i_cModelFlux_inner`,
`i_cModel_flag`,
`i_cModel_flag_apCorr`,
`i_calibFlux`,
`i_calibFluxErr`,
`i_calibFlux_flag`,
`i_calibFlux_flag_apertureTruncated`,
`i_calibFlux_flag_sincCoeffsTruncated`,
`i_calib_astrometry_used`,
`i_calib_photometry_reserved`,
`i_calib_photometry_used`,
`i_calib_psf_candidate`,
`i_calib_psf_reserved`,
`i_calib_psf_used`,
`i_centroid_flag`,
`i_centroid_x`,
`i_centroid_xErr`,
`i_centroid_y`,
`i_centroid_yErr`,
`i_decl`,
`i_extendedness`,
`i_extendedness_flag`,
`i_free_cModelFlux`,
`i_free_cModelFluxErr`,
`i_free_cModelFlux_flag`,
`i_free_cModelFlux_inner`,
`i_free_psfFlux`,
`i_free_psfFluxErr`,
`i_free_psfFlux_flag`,
`i_fwhm`,
`i_gaap0p5Flux`,
`i_gaap0p5FluxErr`,
`i_gaap0p5Flux_flag_bigPsf`,
`i_gaap0p7Flux`,
`i_gaap0p7FluxErr`,
`i_gaap0p7Flux_flag_bigPsf`,
`i_gaap1p0Flux`,
`i_gaap1p0FluxErr`,
`i_gaap1p0Flux_flag_bigPsf`,
`i_gaap1p5Flux`,
`i_gaap1p5FluxErr`,
`i_gaap1p5Flux_flag_bigPsf`,
`i_gaap2p5Flux`,
`i_gaap2p5FluxErr`,
`i_gaap2p5Flux_flag_bigPsf`,
`i_gaap3p0Flux`,
`i_gaap3p0FluxErr`,
`i_gaap3p0Flux_flag_bigPsf`,
`i_gaapFlux_flag`,
`i_gaapFlux_flag_edge`,
`i_gaapFlux_flag_gaussianization`,
`i_gaapOptimalFlux`,
`i_gaapOptimalFluxErr`,
`i_gaapOptimalFlux_flag_bigPsf`,
`i_gaapPsfFlux`,
`i_gaapPsfFluxErr`,
`i_hsmShapeRegauss_e1`,
`i_hsmShapeRegauss_e2`,
`i_hsmShapeRegauss_flag`,
`i_hsmShapeRegauss_sigma`,
`i_iDebiasedPSF_flag`,
`i_iPSF_flag`,
`i_iRound_flag`,
`i_i_flag`,
`i_inputCount`,
`i_inputCount_flag`,
`i_inputCount_flag_noInputs`,
`i_ixx`,
`i_ixxDebiasedPSF`,
`i_ixxPSF`,
`i_ixxRound`,
`i_ixy`,
`i_ixyDebiasedPSF`,
`i_ixyPSF`,
`i_ixyRound`,
`i_iyy`,
`i_iyyDebiasedPSF`,
`i_iyyPSF`,
`i_iyyRound`,
`i_kronFlux`,
`i_kronFluxErr`,
`i_kronFlux_flag`,
`i_kronFlux_flag_bad_radius`,
`i_kronFlux_flag_bad_shape`,
`i_kronFlux_flag_bad_shape_no_psf`,
`i_kronFlux_flag_edge`,
`i_kronFlux_flag_no_fallback_radius`,
`i_kronFlux_flag_no_minimum_radius`,
`i_kronFlux_flag_small_radius`,
`i_kronFlux_flag_used_minimum_radius`,
`i_kronFlux_flag_used_psf_radius`,
`i_kronRad`,
`i_pixelFlags_bad`,
`i_pixelFlags_clipped`,
`i_pixelFlags_clippedCenter`,
`i_pixelFlags_cr`,
`i_pixelFlags_crCenter`,
`i_pixelFlags_edge`,
`i_pixelFlags_inexact_psf`,
`i_pixelFlags_inexact_psfCenter`,
`i_pixelFlags_interpolated`,
`i_pixelFlags_interpolatedCenter`,
`i_pixelFlags_offimage`,
`i_pixelFlags_saturated`,
`i_pixelFlags_saturatedCenter`,
`i_pixelFlags_sensor_edge`,
`i_pixelFlags_sensor_edgeCenter`,
`i_pixelFlags_suspect`,
`i_pixelFlags_suspectCenter`,
`i_psfFlux`,
`i_psfFluxErr`,
`i_psfFlux_area`,
`i_psfFlux_flag`,
`i_psfFlux_flag_apCorr`,
`i_psfFlux_flag_edge`,
`i_psfFlux_flag_noGoodPixels`,
`i_ra`,
`r_ap03Flux`,
`r_ap03FluxErr`,
`r_ap03Flux_flag`,
`r_ap06Flux`,
`r_ap06FluxErr`,
`r_ap06Flux_flag`,
`r_ap09Flux`,
`r_ap09FluxErr`,
`r_ap09Flux_flag`,
`r_ap12Flux`,
`r_ap12FluxErr`,
`r_ap12Flux_flag`,
`r_ap17Flux`,
`r_ap17FluxErr`,
`r_ap17Flux_flag`,
`r_ap25Flux`,
`r_ap25FluxErr`,
`r_ap25Flux_flag`,
`r_ap35Flux`,
`r_ap35FluxErr`,
`r_ap35Flux_flag`,
`r_ap50Flux`,
`r_ap50FluxErr`,
`r_ap50Flux_flag`,
`r_ap70Flux`,
`r_ap70FluxErr`,
`r_ap70Flux_flag`,
`r_apFlux_flag`,
`r_apFlux_flag_apertureTruncated`,
`r_apFlux_flag_sincCoeffsTruncated`,
`r_bdChi2`,
`r_bdE1`,
`r_bdE2`,
`r_bdFluxB`,
`r_bdFluxBErr`,
`r_bdFluxD`,
`r_bdFluxDErr`,
`r_bdReB`,
`r_bdReD`,
`r_blendedness`,
`r_blendedness_flag`,
`r_cModelFlux`,
`r_cModelFluxErr`,
`r_cModelFlux_inner`,
`r_cModel_flag`,
`r_cModel_flag_apCorr`,
`r_calibFlux`,
`r_calibFluxErr`,
`r_calibFlux_flag`,
`r_calibFlux_flag_apertureTruncated`,
`r_calibFlux_flag_sincCoeffsTruncated`,
`r_calib_astrometry_used`,
`r_calib_photometry_reserved`,
`r_calib_photometry_used`,
`r_calib_psf_candidate`,
`r_calib_psf_reserved`,
`r_calib_psf_used`,
`r_centroid_flag`,
`r_centroid_x`,
`r_centroid_xErr`,
`r_centroid_y`,
`r_centroid_yErr`,
`r_decl`,
`r_extendedness`,
`r_extendedness_flag`,
`r_free_cModelFlux`,
`r_free_cModelFluxErr`,
`r_free_cModelFlux_flag`,
`r_free_cModelFlux_inner`,
`r_free_psfFlux`,
`r_free_psfFluxErr`,
`r_free_psfFlux_flag`,
`r_fwhm`,
`r_gaap0p5Flux`,
`r_gaap0p5FluxErr`,
`r_gaap0p5Flux_flag_bigPsf`,
`r_gaap0p7Flux`,
`r_gaap0p7FluxErr`,
`r_gaap0p7Flux_flag_bigPsf`,
`r_gaap1p0Flux`,
`r_gaap1p0FluxErr`,
`r_gaap1p0Flux_flag_bigPsf`,
`r_gaap1p5Flux`,
`r_gaap1p5FluxErr`,
`r_gaap1p5Flux_flag_bigPsf`,
`r_gaap2p5Flux`,
`r_gaap2p5FluxErr`,
`r_gaap2p5Flux_flag_bigPsf`,
`r_gaap3p0Flux`,
`r_gaap3p0FluxErr`,
`r_gaap3p0Flux_flag_bigPsf`,
`r_gaapFlux_flag`,
`r_gaapFlux_flag_edge`,
`r_gaapFlux_flag_gaussianization`,
`r_gaapOptimalFlux`,
`r_gaapOptimalFluxErr`,
`r_gaapOptimalFlux_flag_bigPsf`,
`r_gaapPsfFlux`,
`r_gaapPsfFluxErr`,
`r_hsmShapeRegauss_e1`,
`r_hsmShapeRegauss_e2`,
`r_hsmShapeRegauss_flag`,
`r_hsmShapeRegauss_sigma`,
`r_iDebiasedPSF_flag`,
`r_iPSF_flag`,
`r_iRound_flag`,
`r_i_flag`,
`r_inputCount`,
`r_inputCount_flag`,
`r_inputCount_flag_noInputs`,
`r_ixx`,
`r_ixxDebiasedPSF`,
`r_ixxPSF`,
`r_ixxRound`,
`r_ixy`,
`r_ixyDebiasedPSF`,
`r_ixyPSF`,
`r_ixyRound`,
`r_iyy`,
`r_iyyDebiasedPSF`,
`r_iyyPSF`,
`r_iyyRound`,
`r_kronFlux`,
`r_kronFluxErr`,
`r_kronFlux_flag`,
`r_kronFlux_flag_bad_radius`,
`r_kronFlux_flag_bad_shape`,
`r_kronFlux_flag_bad_shape_no_psf`,
`r_kronFlux_flag_edge`,
`r_kronFlux_flag_no_fallback_radius`,
`r_kronFlux_flag_no_minimum_radius`,
`r_kronFlux_flag_small_radius`,
`r_kronFlux_flag_used_minimum_radius`,
`r_kronFlux_flag_used_psf_radius`,
`r_kronRad`,
`r_pixelFlags_bad`,
`r_pixelFlags_clipped`,
`r_pixelFlags_clippedCenter`,
`r_pixelFlags_cr`,
`r_pixelFlags_crCenter`,
`r_pixelFlags_edge`,
`r_pixelFlags_inexact_psf`,
`r_pixelFlags_inexact_psfCenter`,
`r_pixelFlags_interpolated`,
`r_pixelFlags_interpolatedCenter`,
`r_pixelFlags_offimage`,
`r_pixelFlags_saturated`,
`r_pixelFlags_saturatedCenter`,
`r_pixelFlags_sensor_edge`,
`r_pixelFlags_sensor_edgeCenter`,
`r_pixelFlags_suspect`,
`r_pixelFlags_suspectCenter`,
`r_psfFlux`,
`r_psfFluxErr`,
`r_psfFlux_area`,
`r_psfFlux_flag`,
`r_psfFlux_flag_apCorr`,
`r_psfFlux_flag_edge`,
`r_psfFlux_flag_noGoodPixels`,
`r_ra`,
`u_ap03Flux`,
`u_ap03FluxErr`,
`u_ap03Flux_flag`,
`u_ap06Flux`,
`u_ap06FluxErr`,
`u_ap06Flux_flag`,
`u_ap09Flux`,
`u_ap09FluxErr`,
`u_ap09Flux_flag`,
`u_ap12Flux`,
`u_ap12FluxErr`,
`u_ap12Flux_flag`,
`u_ap17Flux`,
`u_ap17FluxErr`,
`u_ap17Flux_flag`,
`u_ap25Flux`,
`u_ap25FluxErr`,
`u_ap25Flux_flag`,
`u_ap35Flux`,
`u_ap35FluxErr`,
`u_ap35Flux_flag`,
`u_ap50Flux`,
`u_ap50FluxErr`,
`u_ap50Flux_flag`,
`u_ap70Flux`,
`u_ap70FluxErr`,
`u_ap70Flux_flag`,
`u_apFlux_flag`,
`u_apFlux_flag_apertureTruncated`,
`u_apFlux_flag_sincCoeffsTruncated`,
`u_bdChi2`,
`u_bdE1`,
`u_bdE2`,
`u_bdFluxB`,
`u_bdFluxBErr`,
`u_bdFluxD`,
`u_bdFluxDErr`,
`u_bdReB`,
`u_bdReD`,
`u_blendedness`,
`u_blendedness_flag`,
`u_cModelFlux`,
`u_cModelFluxErr`,
`u_cModelFlux_inner`,
`u_cModel_flag`,
`u_cModel_flag_apCorr`,
`u_calibFlux`,
`u_calibFluxErr`,
`u_calibFlux_flag`,
`u_calibFlux_flag_apertureTruncated`,
`u_calibFlux_flag_sincCoeffsTruncated`,
`u_calib_astrometry_used`,
`u_calib_photometry_reserved`,
`u_calib_photometry_used`,
`u_calib_psf_candidate`,
`u_calib_psf_reserved`,
`u_calib_psf_used`,
`u_centroid_flag`,
`u_centroid_x`,
`u_centroid_xErr`,
`u_centroid_y`,
`u_centroid_yErr`,
`u_decl`,
`u_extendedness`,
`u_extendedness_flag`,
`u_free_cModelFlux`,
`u_free_cModelFluxErr`,
`u_free_cModelFlux_flag`,
`u_free_cModelFlux_inner`,
`u_free_psfFlux`,
`u_free_psfFluxErr`,
`u_free_psfFlux_flag`,
`u_fwhm`,
`u_gaap0p5Flux`,
`u_gaap0p5FluxErr`,
`u_gaap0p5Flux_flag_bigPsf`,
`u_gaap0p7Flux`,
`u_gaap0p7FluxErr`,
`u_gaap0p7Flux_flag_bigPsf`,
`u_gaap1p0Flux`,
`u_gaap1p0FluxErr`,
`u_gaap1p0Flux_flag_bigPsf`,
`u_gaap1p5Flux`,
`u_gaap1p5FluxErr`,
`u_gaap1p5Flux_flag_bigPsf`,
`u_gaap2p5Flux`,
`u_gaap2p5FluxErr`,
`u_gaap2p5Flux_flag_bigPsf`,
`u_gaap3p0Flux`,
`u_gaap3p0FluxErr`,
`u_gaap3p0Flux_flag_bigPsf`,
`u_gaapFlux_flag`,
`u_gaapFlux_flag_edge`,
`u_gaapFlux_flag_gaussianization`,
`u_gaapOptimalFlux`,
`u_gaapOptimalFluxErr`,
`u_gaapOptimalFlux_flag_bigPsf`,
`u_gaapPsfFlux`,
`u_gaapPsfFluxErr`,
`u_hsmShapeRegauss_e1`,
`u_hsmShapeRegauss_e2`,
`u_hsmShapeRegauss_flag`,
`u_hsmShapeRegauss_sigma`,
`u_iDebiasedPSF_flag`,
`u_iPSF_flag`,
`u_iRound_flag`,
`u_i_flag`,
`u_inputCount`,
`u_inputCount_flag`,
`u_inputCount_flag_noInputs`,
`u_ixx`,
`u_ixxDebiasedPSF`,
`u_ixxPSF`,
`u_ixxRound`,
`u_ixy`,
`u_ixyDebiasedPSF`,
`u_ixyPSF`,
`u_ixyRound`,
`u_iyy`,
`u_iyyDebiasedPSF`,
`u_iyyPSF`,
`u_iyyRound`,
`u_kronFlux`,
`u_kronFluxErr`,
`u_kronFlux_flag`,
`u_kronFlux_flag_bad_radius`,
`u_kronFlux_flag_bad_shape`,
`u_kronFlux_flag_bad_shape_no_psf`,
`u_kronFlux_flag_edge`,
`u_kronFlux_flag_no_fallback_radius`,
`u_kronFlux_flag_no_minimum_radius`,
`u_kronFlux_flag_small_radius`,
`u_kronFlux_flag_used_minimum_radius`,
`u_kronFlux_flag_used_psf_radius`,
`u_kronRad`,
`u_pixelFlags_bad`,
`u_pixelFlags_clipped`,
`u_pixelFlags_clippedCenter`,
`u_pixelFlags_cr`,
`u_pixelFlags_crCenter`,
`u_pixelFlags_edge`,
`u_pixelFlags_inexact_psf`,
`u_pixelFlags_inexact_psfCenter`,
`u_pixelFlags_interpolated`,
`u_pixelFlags_interpolatedCenter`,
`u_pixelFlags_offimage`,
`u_pixelFlags_saturated`,
`u_pixelFlags_saturatedCenter`,
`u_pixelFlags_sensor_edge`,
`u_pixelFlags_sensor_edgeCenter`,
`u_pixelFlags_suspect`,
`u_pixelFlags_suspectCenter`,
`u_psfFlux`,
`u_psfFluxErr`,
`u_psfFlux_area`,
`u_psfFlux_flag`,
`u_psfFlux_flag_apCorr`,
`u_psfFlux_flag_edge`,
`u_psfFlux_flag_noGoodPixels`,
`u_ra`,
`y_ap03Flux`,
`y_ap03FluxErr`,
`y_ap03Flux_flag`,
`y_ap06Flux`,
`y_ap06FluxErr`,
`y_ap06Flux_flag`,
`y_ap09Flux`,
`y_ap09FluxErr`,
`y_ap09Flux_flag`,
`y_ap12Flux`,
`y_ap12FluxErr`,
`y_ap12Flux_flag`,
`y_ap17Flux`,
`y_ap17FluxErr`,
`y_ap17Flux_flag`,
`y_ap25Flux`,
`y_ap25FluxErr`,
`y_ap25Flux_flag`,
`y_ap35Flux`,
`y_ap35FluxErr`,
`y_ap35Flux_flag`,
`y_ap50Flux`,
`y_ap50FluxErr`,
`y_ap50Flux_flag`,
`y_ap70Flux`,
`y_ap70FluxErr`,
`y_ap70Flux_flag`,
`y_apFlux_flag`,
`y_apFlux_flag_apertureTruncated`,
`y_apFlux_flag_sincCoeffsTruncated`,
`y_bdChi2`,
`y_bdE1`,
`y_bdE2`,
`y_bdFluxB`,
`y_bdFluxBErr`,
`y_bdFluxD`,
`y_bdFluxDErr`,
`y_bdReB`,
`y_bdReD`,
`y_blendedness`,
`y_blendedness_flag`,
`y_cModelFlux`,
`y_cModelFluxErr`,
`y_cModelFlux_inner`,
`y_cModel_flag`,
`y_cModel_flag_apCorr`,
`y_calibFlux`,
`y_calibFluxErr`,
`y_calibFlux_flag`,
`y_calibFlux_flag_apertureTruncated`,
`y_calibFlux_flag_sincCoeffsTruncated`,
`y_calib_astrometry_used`,
`y_calib_photometry_reserved`,
`y_calib_photometry_used`,
`y_calib_psf_candidate`,
`y_calib_psf_reserved`,
`y_calib_psf_used`,
`y_centroid_flag`,
`y_centroid_x`,
`y_centroid_xErr`,
`y_centroid_y`,
`y_centroid_yErr`,
`y_decl`,
`y_extendedness`,
`y_extendedness_flag`,
`y_free_cModelFlux`,
`y_free_cModelFluxErr`,
`y_free_cModelFlux_flag`,
`y_free_cModelFlux_inner`,
`y_free_psfFlux`,
`y_free_psfFluxErr`,
`y_free_psfFlux_flag`,
`y_fwhm`,
`y_gaap0p5Flux`,
`y_gaap0p5FluxErr`,
`y_gaap0p5Flux_flag_bigPsf`,
`y_gaap0p7Flux`,
`y_gaap0p7FluxErr`,
`y_gaap0p7Flux_flag_bigPsf`,
`y_gaap1p0Flux`,
`y_gaap1p0FluxErr`,
`y_gaap1p0Flux_flag_bigPsf`,
`y_gaap1p5Flux`,
`y_gaap1p5FluxErr`,
`y_gaap1p5Flux_flag_bigPsf`,
`y_gaap2p5Flux`,
`y_gaap2p5FluxErr`,
`y_gaap2p5Flux_flag_bigPsf`,
`y_gaap3p0Flux`,
`y_gaap3p0FluxErr`,
`y_gaap3p0Flux_flag_bigPsf`,
`y_gaapFlux_flag`,
`y_gaapFlux_flag_edge`,
`y_gaapFlux_flag_gaussianization`,
`y_gaapOptimalFlux`,
`y_gaapOptimalFluxErr`,
`y_gaapOptimalFlux_flag_bigPsf`,
`y_gaapPsfFlux`,
`y_gaapPsfFluxErr`,
`y_hsmShapeRegauss_e1`,
`y_hsmShapeRegauss_e2`,
`y_hsmShapeRegauss_flag`,
`y_hsmShapeRegauss_sigma`,
`y_iDebiasedPSF_flag`,
`y_iPSF_flag`,
`y_iRound_flag`,
`y_i_flag`,
`y_inputCount`,
`y_inputCount_flag`,
`y_inputCount_flag_noInputs`,
`y_ixx`,
`y_ixxDebiasedPSF`,
`y_ixxPSF`,
`y_ixxRound`,
`y_ixy`,
`y_ixyDebiasedPSF`,
`y_ixyPSF`,
`y_ixyRound`,
`y_iyy`,
`y_iyyDebiasedPSF`,
`y_iyyPSF`,
`y_iyyRound`,
`y_kronFlux`,
`y_kronFluxErr`,
`y_kronFlux_flag`,
`y_kronFlux_flag_bad_radius`,
`y_kronFlux_flag_bad_shape`,
`y_kronFlux_flag_bad_shape_no_psf`,
`y_kronFlux_flag_edge`,
`y_kronFlux_flag_no_fallback_radius`,
`y_kronFlux_flag_no_minimum_radius`,
`y_kronFlux_flag_small_radius`,
`y_kronFlux_flag_used_minimum_radius`,
`y_kronFlux_flag_used_psf_radius`,
`y_kronRad`,
`y_pixelFlags_bad`,
`y_pixelFlags_clipped`,
`y_pixelFlags_clippedCenter`,
`y_pixelFlags_cr`,
`y_pixelFlags_crCenter`,
`y_pixelFlags_edge`,
`y_pixelFlags_inexact_psf`,
`y_pixelFlags_inexact_psfCenter`,
`y_pixelFlags_interpolated`,
`y_pixelFlags_interpolatedCenter`,
`y_pixelFlags_offimage`,
`y_pixelFlags_saturated`,
`y_pixelFlags_saturatedCenter`,
`y_pixelFlags_sensor_edge`,
`y_pixelFlags_sensor_edgeCenter`,
`y_pixelFlags_suspect`,
`y_pixelFlags_suspectCenter`,
`y_psfFlux`,
`y_psfFluxErr`,
`y_psfFlux_area`,
`y_psfFlux_flag`,
`y_psfFlux_flag_apCorr`,
`y_psfFlux_flag_edge`,
`y_psfFlux_flag_noGoodPixels`,
`y_ra`,
`z_ap03Flux`,
`z_ap03FluxErr`,
`z_ap03Flux_flag`,
`z_ap06Flux`,
`z_ap06FluxErr`,
`z_ap06Flux_flag`,
`z_ap09Flux`,
`z_ap09FluxErr`,
`z_ap09Flux_flag`,
`z_ap12Flux`,
`z_ap12FluxErr`,
`z_ap12Flux_flag`,
`z_ap17Flux`,
`z_ap17FluxErr`,
`z_ap17Flux_flag`,
`z_ap25Flux`,
`z_ap25FluxErr`,
`z_ap25Flux_flag`,
`z_ap35Flux`,
`z_ap35FluxErr`,
`z_ap35Flux_flag`,
`z_ap50Flux`,
`z_ap50FluxErr`,
`z_ap50Flux_flag`,
`z_ap70Flux`,
`z_ap70FluxErr`,
`z_ap70Flux_flag`,
`z_apFlux_flag`,
`z_apFlux_flag_apertureTruncated`,
`z_apFlux_flag_sincCoeffsTruncated`,
`z_bdChi2`,
`z_bdE1`,
`z_bdE2`,
`z_bdFluxB`,
`z_bdFluxBErr`,
`z_bdFluxD`,
`z_bdFluxDErr`,
`z_bdReB`,
`z_bdReD`,
`z_blendedness`,
`z_blendedness_flag`,
`z_cModelFlux`,
`z_cModelFluxErr`,
`z_cModelFlux_inner`,
`z_cModel_flag`,
`z_cModel_flag_apCorr`,
`z_calibFlux`,
`z_calibFluxErr`,
`z_calibFlux_flag`,
`z_calibFlux_flag_apertureTruncated`,
`z_calibFlux_flag_sincCoeffsTruncated`,
`z_calib_astrometry_used`,
`z_calib_photometry_reserved`,
`z_calib_photometry_used`,
`z_calib_psf_candidate`,
`z_calib_psf_reserved`,
`z_calib_psf_used`,
`z_centroid_flag`,
`z_centroid_x`,
`z_centroid_xErr`,
`z_centroid_y`,
`z_centroid_yErr`,
`z_decl`,
`z_extendedness`,
`z_extendedness_flag`,
`z_free_cModelFlux`,
`z_free_cModelFluxErr`,
`z_free_cModelFlux_flag`,
`z_free_cModelFlux_inner`,
`z_free_psfFlux`,
`z_free_psfFluxErr`,
`z_free_psfFlux_flag`,
`z_fwhm`,
`z_gaap0p5Flux`,
`z_gaap0p5FluxErr`,
`z_gaap0p5Flux_flag_bigPsf`,
`z_gaap0p7Flux`,
`z_gaap0p7FluxErr`,
`z_gaap0p7Flux_flag_bigPsf`,
`z_gaap1p0Flux`,
`z_gaap1p0FluxErr`,
`z_gaap1p0Flux_flag_bigPsf`,
`z_gaap1p5Flux`,
`z_gaap1p5FluxErr`,
`z_gaap1p5Flux_flag_bigPsf`,
`z_gaap2p5Flux`,
`z_gaap2p5FluxErr`,
`z_gaap2p5Flux_flag_bigPsf`,
`z_gaap3p0Flux`,
`z_gaap3p0FluxErr`,
`z_gaap3p0Flux_flag_bigPsf`,
`z_gaapFlux_flag`,
`z_gaapFlux_flag_edge`,
`z_gaapFlux_flag_gaussianization`,
`z_gaapOptimalFlux`,
`z_gaapOptimalFluxErr`,
`z_gaapOptimalFlux_flag_bigPsf`,
`z_gaapPsfFlux`,
`z_gaapPsfFluxErr`,
`z_hsmShapeRegauss_e1`,
`z_hsmShapeRegauss_e2`,
`z_hsmShapeRegauss_flag`,
`z_hsmShapeRegauss_sigma`,
`z_iDebiasedPSF_flag`,
`z_iPSF_flag`,
`z_iRound_flag`,
`z_i_flag`,
`z_inputCount`,
`z_inputCount_flag`,
`z_inputCount_flag_noInputs`,
`z_ixx`,
`z_ixxDebiasedPSF`,
`z_ixxPSF`,
`z_ixxRound`,
`z_ixy`,
`z_ixyDebiasedPSF`,
`z_ixyPSF`,
`z_ixyRound`,
`z_iyy`,
`z_iyyDebiasedPSF`,
`z_iyyPSF`,
`z_iyyRound`,
`z_kronFlux`,
`z_kronFluxErr`,
`z_kronFlux_flag`,
`z_kronFlux_flag_bad_radius`,
`z_kronFlux_flag_bad_shape`,
`z_kronFlux_flag_bad_shape_no_psf`,
`z_kronFlux_flag_edge`,
`z_kronFlux_flag_no_fallback_radius`,
`z_kronFlux_flag_no_minimum_radius`,
`z_kronFlux_flag_small_radius`,
`z_kronFlux_flag_used_minimum_radius`,
`z_kronFlux_flag_used_psf_radius`,
`z_kronRad`,
`z_pixelFlags_bad`,
`z_pixelFlags_clipped`,
`z_pixelFlags_clippedCenter`,
`z_pixelFlags_cr`,
`z_pixelFlags_crCenter`,
`z_pixelFlags_edge`,
`z_pixelFlags_inexact_psf`,
`z_pixelFlags_inexact_psfCenter`,
`z_pixelFlags_interpolated`,
`z_pixelFlags_interpolatedCenter`,
`z_pixelFlags_offimage`,
`z_pixelFlags_saturated`,
`z_pixelFlags_saturatedCenter`,
`z_pixelFlags_sensor_edge`,
`z_pixelFlags_sensor_edgeCenter`,
`z_pixelFlags_suspect`,
`z_pixelFlags_suspectCenter`,
`z_psfFlux`,
`z_psfFluxErr`,
`z_psfFlux_area`,
`z_psfFlux_flag`,
`z_psfFlux_flag_apCorr`,
`z_psfFlux_flag_edge`,
`z_psfFlux_flag_noGoodPixels`,
`z_ra`,
`chunkId`,
`subChunkId`
FROM dp02_dc2_catalogs.Object
ORDER BY coord_ra ASC
LIMIT 1000

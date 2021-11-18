DELETE FROM mysql.db WHERE user='qsmaster';
GRANT ALL ON `qservw_worker`.* TO 'qsmaster'@'127.0.0.1';
GRANT ALL ON `q\_memoryLockDb`.* TO 'qsmaster'@'127.0.0.1';
GRANT ALL ON `Subchunks\_%`.* TO 'qsmaster'@'127.0.0.1';
GRANT ALL ON dp01_dc2_catalogs.* TO 'qsmaster'@'127.0.0.1';
GRANT ALL ON dp01_dc2_catalogs_01.* TO 'qsmaster'@'127.0.0.1';
GRANT ALL ON gaia_dr2_02.* TO 'qsmaster'@'127.0.0.1';
GRANT ALL ON hsc_pdr2_2020_08_01.* TO 'qsmaster'@'127.0.0.1';
GRANT ALL ON hsc_pdr2_2020_09_00.* TO 'qsmaster'@'127.0.0.1';
GRANT ALL ON hsc_rc2_w_2021_02_00.* TO 'qsmaster'@'127.0.0.1';
GRANT ALL ON wise_01.* TO 'qsmaster'@'127.0.0.1';


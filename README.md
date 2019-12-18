# TRULS-opptaker
Shell-scripts og SystemD-services for opptak av video fra radiostudio.

## Oppsett

Først og fremst så må `bmdcapture` installeres. Dette er et BlackMagic-program
som du får med en av programvarepakkene deres.

Du må også sette opp en mappe hvor opptakene kan lagres, og som nginx da kan
servere til brukere. I skriptet er dette satt til `/opptak`.

Klon repoet, for eksempel til `/srv/TRULS-opptaker`.

```sh
sudo ln -s /srv/TRULS-opptaker/bmd.sh /usr/local/bin/bmd.sh
sudo ln -s /srv/TRULS-opptaker/ffmpeg.sh /usr/local/bin/ffmpeg.sh
sudo ln -s /srv/TRULS-opptaker/nyesnattsending /usr/local/bin/nyesnattsending
sudo ln -s /srv/TRULS-opptaker/slettopptak /usr/local/bin/slettopptak
sudo cp nyes-nattsending.service video-opptaker-{ffmpeg,bmd}.service video-opptaker.socket slett-opptak.{timer,service} /etc/systemd/system
sudo systemctl daemon-reload
sudo systemctl enable --now video-opptaker-{bmd,ffmpeg} slett-opptak.timer
```

Ved oppdatering av `video-opptaker-bmd.service`, `video-opptaker-ffmpeg.service`,
`video-opptaker.socket`, `nyes-nattsending.service`, `slett-opptak.service` og 
`slett-opptak.timer` må du kopiere over den endra fila til `/etc/systemd/system`.
De kan ikke symlinkes, fordi SystemD ikke leser symlinka filer.
Kjør `sudo systemctl daemon-reload` når filene er oppdatert.

## Viktig info

`video-opptaker-bmd.service` inneholder CPUAffinity som er satt til CPU 7.
Hvis man skal installere dette på en maskin med mindre enn 8 tråder (4 kjerner
med hyper-threading aktivert), må dette endres eller fjernes. Grunnen til at
CPUAffinity er i bruk er at dette sørger for at bmdcapture prosessen, som er
enkelttrådet, alltid kjører på samme kjerne og dermed kan gjenbruke cachen.

`video-opptaker-bmd.service` og  `video-opptaker-ffmpeg.service` har
OOMScoreAdjust satt til en verdi som gjør at det er mindre sjanse for at disse
prosessene blir stoppen enn andre prosesser. Grunnen til dette er at begge
prosessene bør kjøre noenlunde i sanntid, bmd mer enn ffmpeg, og dermed vil en
restart føre til tap av opptak.

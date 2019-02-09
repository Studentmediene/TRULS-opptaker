# TRULS-opptaker
Shell-scripts og SystemD-services for opptak av video fra radiostudio.

## Oppsett

Først og fremst så må `bmdcapture` installeres. Dette er et BlackMagic-program
som du får med en av programvarepakkene deres.

Du må også sette opp en mappe hvor opptakene kan lagres, og som nginx da kan
servere til brukere. I skriptet er dette satt til `/opptak`.

Klon repoet, for eksempel til `/srv/TRULS-opptaker`.

```sh
sudo ln -s /srv/TRULS-opptaker/videoopptaker /usr/local/bin/videoopptaker
sudo ln -s /srv/TRULS-opptaker/nyesnattsending /usr/local/bin/nyesnattsending
sudo ln -s /srv/TRULS-opptaker/slettopptak /usr/local/bin/slettopptak
sudo cp nyes-nattsending.service video-opptaker.service slett-opptak.{timer,service} /etc/systemd/system
sudo systemctl daemon-reload
sudo systemctl enable --now video-opptaker slett-opptak.timer
```

Ved oppdatering av `video-opptaker.service`, `nyes-nattsending.service`,
`slett-opptak.service` og `slett-opptak.timer` må du kopiere over den endra fila
til `/etc/systemd/system`. De kan ikke symlinkes, fordi SystemD ikke leser
symlinka filer. Kjør `sudo systemctl daemon-reload` når filene er oppdatert.

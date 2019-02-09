# TRULS-opptaker
Shell-scripts og SystemD-services for opptak av video fra radiostudio.

## Oppsett

Først og fremst så må `bmdcapture` installeres. Dette er et BlackMagic-program
som du får med en av programvarepakkene deres.

Klon repoet, for eksempel til `/srv/TRULS-opptaker`.

```sh
sudo ln -s /srv/TRULS-opptaker/videoopptaker /usr/local/bin/videoopptaker
sudo ln -s /srv/TRULS-opptaker/nyesnattsending /usr/local/bin/nyesnattsending
sudo cp nyes-nattsending.service video-opptaker.service /etc/systemd/system
sudo systemctl daemon-reload
sudo systemctl enable video-opptaker
```

Du må sette opp en mappe hvor opptakene kan lagres, og som nginx da kan servere
til brukere.

Ved oppdatering av `video-opptaker.service` eller `nyes-nattsending.service`, må
du kopiere over den endra fila til `/etc/systemd/system`. De kan ikke symlinkes,
fordi SystemD ikke leser symlinka filer.

# project_3_mobile_app_layout

An imitation of Google Podcast's main page.

## Tasks & Results

1. This project already was mostly decomposed on Stateful and Stateless widgets
2. State changes was implemented in ListPoint, PlayPanel, EpisodeTile and MainPage (_setCurrentPlayingEpisode(), FAB's onTap)
3. "Lifting state up" principle was demonstrated using EpisodeTile and PlayPanel
   - PlayPanel's field episode was moved up to the MainPage class (field name: currentPlayingEpisode)
   - Method _setCurrentPlayingEpisode() was created and passed down to EpisodeTile (so it's button can change the state of the MainPage)

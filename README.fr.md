# 🪨🍃✂️ Rock Paper Scissor - Jeu Mobile Flutter

Un jeu mobile élégant développé avec **Flutter** où vous affrontez l'ordinateur dans des parties endiablées de **Pierre – Feuille – Ciseaux**.

## 🎯 Fonctionnalités Avancées

* **Interface intuitive** avec design Material 3 et animations fluides
* **Système de jeu équilibré** : l'IA génère des choix aléatoires pour garantir des parties équitables
* **Affichage des résultats détaillé** après chaque manche avec indicateurs visuels
* **Mode compétition** : 1 vs 1 et le premier à atteindre **3 points** remporte la victoire
* **Gestion intelligente des égalités** : les matchs nuls n'affectent pas le score
* **Design responsive** optimisé pour mobile (Android & iOS)

## 📸 Aperçu

![Bannière du jeu Rock Paper Scissor](screenshots/rock_paper_scissor_flyer.png)

*(Captures d'écran disponibles dans le dossier `/screenshots/`)*

## 🏗️ Architecture Technique

* **Flutter 3.0+** (Dart 2.17+)
* **State Management** : Gestion d'état native avec setState pour une simplicité maximale
* **UI/UX** : Material Design 3 avec thème personnalisé et animations implicites
* **Compatibilité** : Support natif Android & iOS avec performances optimisées

## 🚀 Démarrage Rapide

1. Clonez le dépôt :

   ```bash
   git clone https://github.com/dididnk/rock_paper_scissor.git
   cd rock_paper_scissor
   ```

2. Installez les dépendances :

   ```bash
   flutter pub get
   ```

3. Lancez l'application :

   ```bash
   flutter run
   ```

## 📂 Structure du Projet

```bash
lib/
 ├─ main.dart                 # Point d'entrée et configuration de l'application
 ├─ providers/
 │   └─ local_provider.dart      # Gestion de changement de langue
 ├─ utils/
 │   ├─ theme/
 │       ├─ app_colors.dart     
 │       ├─ app_theme.dart     
 │   ├─ global_constances.dart
 ├─ widgets/
 │   ├─ custom_button.dart   # Bouton de sélection (pierre, feuille, ciseaux)
 │   ├─ score_board_widget.dart      # Affichage du score et des résultats
 │   ├─ final_result_widget.dart      # Affichage du score final
 │   └─ language_widget.dart     # Permet de selectionner une langue
 └─ pages/
     └─ home_page.dart       # Écran principal avec composition des widgets
```

## 🎮 Comment Jouer

1. Appuyez sur l'un des trois boutons pour faire votre choix
2. L'ordinateur génère instantanément son mouvement
3. Le résultat s'affiche avec un message clair (Victoire, Défaite ou Égalité)
4. Le score est mis à jour automatiquement
5. La première équipe à 3 points remporte la partie !

## 📝 Prochaines Améliorations

- [ ] Mode multijoueur local
- [ ] Historique des parties
- [ ] Effets sonores et vibrations
- [ ] Thèmes personnalisables (pour l'instant ça applique le thème par défaut)
- [ ] Mode difficulté variable (IA adaptative)

---

**Langues prises en charge: 🇫🇷, 🇺🇸, 🇪🇸, 🇩🇪, 🇮🇹, 🇵🇹, 🇷🇺, 🇨🇳.**

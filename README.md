# Fitelo App Assignment – Goal → Pace → Calories Flow

A **Flutter assignment project** demonstrating a 3-step interactive flow where users can:
1. Set a **weight loss goal (0–40 kg)** using a custom-built dial.
2. Choose their **timeline/pace** using segmented presets and slider control.
3. View a **personalized daily calorie target** with macro breakdown (carbs, protein, fat).

---

## Features

### 1. Goal Screen
- Custom **scrollable half-dial** selector (0–40 kg in 0.5 kg steps)
- **Haptic feedback** on each whole-kg tick
- “Recommended” hint card below the dial
- “Start with 0 kg” message when goal = 0
- Value persistently stored using `StorageService`

### 2. Pace Screen
- **Three pace presets:** Gentle (6 months), Recommended (3 months), Intense (1.5 months)
- Fine-tune via slider (1–12 months, 0.5 step)
- Dynamically updates caption and selection state
- Smooth UI animations and reactive design with GetX

### 3. Calorie Screen
- **Ring chart** showing daily calorie target
- Editable **maintenance calories** (default 2200 kcal)
- **Macro cards** for Carbs, Protein, and Fat with gram breakdown
- Formula-driven calculation
- Macros: Carbs 45%, Protein 30%, Fat 25% (rounded to nearest 5g)
- Bottom sheet with full **calculation explanation**

---

## Tech Stack
- **Flutter**
- **State Management:** GetX
- **Local Storage:** SharedPreferences (via custom `StorageService`)
- **Custom UI:** CustomPainter for Dial & Ring Chart
- **Animations:** AnimatedSwitcher, Fade, and Scale transitions
- **Material 3 + Light Theme (Orange accent)**

---

## Installation & Setup

```bash
# Clone the repository
git clone https://github.com/erhrs/fitelo_app_assignment.git
cd fitelo_app_assignment

# Install dependencies
flutter pub get

# Run the app
flutter run

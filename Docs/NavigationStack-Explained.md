# NavigationStack, Explained Like You Are Five

This file is your picture book for how screens move in Himaytek.

Read it slowly. The code changes we made are listed at the bottom. The middle is *why* those changes matter.

---

## The five-year-old version (start here)

Imagine your app is a **desk**.

On the desk you keep a **stack of papers**.

- The paper on the **bottom** is the first screen you saw.
- The paper on the **top** is the screen you are looking at *right now*.
- When you tap something like “Create account”, SwiftUI puts a **new paper on top**.
- When you tap Back, SwiftUI **takes the top paper off**. Now you see the paper that was underneath.

That pile of papers is a `NavigationStack`.

One desk. One pile. That is the whole idea.

If you put a **second desk on top of the first desk**, and each desk has its own pile of papers, you get lost.

- You tap Back on the small desk.
- A paper disappears on the small desk.
- The big desk still has the same papers.
- You think you went “back to login”, but you actually opened **another login paper** on the small desk.

That is what was happening in this app.

---

## What `NavigationStack` actually is

In SwiftUI, a `NavigationStack` is a container that owns a **path** (the pile of screens).

```swift
NavigationStack {
    OnboardingScreensContent()   // this is the first paper
}
```

Anything inside that stack can say:

```swift
NavigationLink {
    LoginView()                  // put this paper on top
}
```

or:

```swift
.navigationDestination(isPresented: $showLogin) {
    LoginView()                  // same idea, just a different doorbell
}
```

Both of those talk to **the nearest NavigationStack above them**.

They do **not** create a new pile. They add to the pile that already exists.

---

## The golden rule (tape this to your monitor)

> A screen that gets *pushed* should almost never create its own `NavigationStack`.
>
> Only the **root of a flow** owns a stack.

In Himaytek there are two flows:

1. **Not logged in** (onboarding → login → signup → forgot password → OTP)
2. **Logged in** (the tab bar: Home, Favorites, Bookings, Profile)

So we want:

- **One** stack for the not-logged-in flow
- **One** stack **per tab** for the logged-in flow

Not one stack per screen. Not one giant stack around the whole tab bar.

---

## How this app is supposed to look (the good map)

### When you are not logged in

```
Window (Main.swift)
└── OnboardingScreens
    └── NavigationStack          ← THIS is the only stack for auth
        ├── paper 1: Onboarding
        ├── paper 2: LoginView          (pushed)
        ├── paper 3: SignupView         (pushed from Login)
        └── paper 3 alt: ForgetPassword (pushed from Login)
              └── paper 4: OTPVerify    (pushed from Forget Password)
```

Login, Signup, Forgot Password, and OTP are just papers. They do not bring their own desks.

### When you are logged in

```
Window (Main.swift)
└── HomeView
    └── TabView
        ├── Tab Home        → NavigationStack → Home → maybe VendorsView
        ├── Tab Favorites   → NavigationStack → FavoritesView → maybe VendorsView
        ├── Tab Bookings    → NavigationStack → BookingsView
        └── Tab Profile     → NavigationStack → ProfileView
```

Each tab has its **own** pile.

Why? Because if you had one pile for the whole tab bar:

1. You open Vendors from Home (pile: Home, Vendors)
2. You switch to Profile
3. You come back to Home
4. You might still be stuck on Vendors, or Back might jump to a weird place

Separate piles mean Home’s Back button never accidentally pops Profile.

Apple’s rule of thumb is: **TabView on the outside, NavigationStack on the inside of each tab.** Never the other way around.

---

## How leaving login works (this part is not a stack)

In `Main.swift` we do **not** push Home on top of Login.

We swap the whole window:

```text
if isLoggedin {
    HomeView()            // throw away the auth desk, put the tab desk down
} else {
    OnboardingScreens()   // throw away the tab desk, put the auth desk down
}
```

That is correct.

A stack is for “go deeper, then come back.”

Logging in is not “go deeper.” Logging in is “this person is a different kind of visitor now.” You throw away the guest papers and put the member desk on the table.

If you pushed Home onto Login’s stack, the Back button could return you to Login while you are still “logged in.” Chaos.

---

## What was wrong before (the bad map)

### Problem 1: Nested stacks (desks on desks)

Onboarding already had a `NavigationStack`.

Then `LoginView` wrapped *itself* in another `NavigationStack`.

Then `SignupView` wrapped *itself* in another `NavigationStack`.

```
Onboarding NavigationStack          ← big desk
  └── LoginView NavigationStack     ← medium desk sitting on the big desk
        └── SignupView NavigationStack  ← tiny desk sitting on the medium desk
```

`NavigationLink` always talks to the **closest** stack.

So when Login said “open Signup”, it did **not** add a paper to Onboarding’s pile.

It added a paper to **Login’s private pile**.

Symptoms you would feel as a user:

- The system Back button feels drunk
- `dismiss()` pops the wrong thing
- Navigation bars appear, disappear, or animate twice
- Previews still look fine, so you do not notice until the real app flow

**Fix:** Remove `NavigationStack` from `LoginView` and `SignupView`. They now live inside Onboarding’s stack.

Forgot Password, OTP, Home content, Vendors, Favorites, and Profile were already doing this right. They never owned a stack.

---

### Problem 2: The Login ↔ Signup hamster wheel

Login had:

```swift
NavigationLink("create") {
    SignupView()
}
```

That means: put Signup on top of Login. Good.

Signup had:

```swift
NavigationLink(destination: LoginView()) {
    Text("login")
}
```

That means: put a **brand new Login** on top of Signup.

Not “go back.” A **copy**.

So the pile grew forever:

```
Onboarding
  Login #1
    Signup #1
      Login #2          ← this is a different Login, with a different ViewModel
        Signup #2
          Login #3
            ...
```

Each new Login forgot what you typed in the previous Login.

Tapping Back from Login #2 would show Signup #1, not Onboarding.

**Fix:** Signup now says `dismiss()`.

`dismiss()` means: take **this** paper off the pile. Signup disappears. Login #1 is still there, with the text you already typed.

Forgot Password already did this correctly with its “Login” button.

---

### Problem 3: Empty `NavigationLink`s (blank papers)

A `NavigationLink` **always** pushes something.

If the destination is empty:

```swift
NavigationLink {
    // nothing here
} label: {
    Image(systemName: "bell.fill")
}
```

SwiftUI still puts a paper on the pile. The paper is blank. You tap the bell, the screen slides, and you stare at nothing.

That is not a button. That is a teleport to an empty room.

Places this happened:

- Home bell
- Home gear
- Home “Book now”
- Home Favorites “See all”
- Vendor cards
- OTP “Verify” (via `CommonButton` with `isNavigation: true` and `EmptyView()`)

**Fix:** Until those screens exist, use a `Button`. A button can do nothing. A `NavigationLink` cannot do nothing.

When you later build Notifications, change the button to a real `NavigationLink { NotificationsView() }`.

---

### Problem 4: OTP Verify was a fake door

`CommonButton` has two modes:

- `isNavigation: true` → it is secretly a `NavigationLink`
- `isNavigation: false` → it is a normal `Button`

OTP used `isNavigation: true` with `destination: EmptyView()`.

Tapping Verify pushed an empty screen.

**Fix:** `isNavigation: false`. When you wire verify to the API, put the work in `action:` (same pattern as Login and Signup).

Forgot Password → OTP is still a real navigation link, because OTP **is** a real next paper.

---

### Problem 5: Bookings tab showed Favorites

The Bookings tab was this:

```swift
NavigationStack {
    FavoritesView()
}
```

Same stack pattern (good). Wrong paper (bad).

It looked like “hearts” because it *was* the hearts screen.

**Fix:** `BookingsView` is its own empty-state screen inside its own stack.

---

### Problem 6: “See all” favorites tried to be a link

The comment in Home said `// tag (1)`, which means “please open tab 1.”

A `NavigationLink` cannot switch tabs. It can only put a paper on **this** tab’s pile.

If we had linked to `FavoritesView()`, you would see Favorites **on the Home tab**, with a Back button, while the real Favorites tab still sat empty. Two copies of the same idea.

**Fix:** HomeView keeps `selectedTab`. “See all” on Home sets `selectedTab = 1`. That is jumping to the other desk, not putting a paper on this desk.

---

### Problem 7: A heart button trapped inside a link

Vendor cards were one giant `NavigationLink` with a Like `Button` inside.

Two tappable things in the same chair fight. Sometimes the like tap also pushes a screen. Sometimes the push eats the like tap.

**Fix:** The card is not a link until there is a vendor-detail screen. The heart stays a button.

---

## Buttons vs links vs dismiss vs swapping the root

Keep these four toys in different boxes.

| Toy | What it means in kid words | When to use it |
|---|---|---|
| `Button` | “Do a thing, stay on this paper.” | Login API call, like a vendor, open camera |
| `NavigationLink` / `navigationDestination` | “Put a new paper on this pile.” | Login → Signup, Home → Vendors |
| `dismiss()` | “Take this paper off.” | Signup → back to Login, OTP back button |
| Change `isLoggedin` | “Replace the whole desk.” | After a real successful login |

Never use a `NavigationLink` when you meant `dismiss()`.
Never use a `NavigationStack` when you meant “I am a paper, not a desk.”

---

## Why TabView needs many stacks, but auth needs one

### Auth is a hallway

Onboarding, Login, Signup, Forgot Password, OTP are rooms in **one hallway**.

You walk forward. You walk back. There is one line of rooms.

One `NavigationStack`.

### Tabs are different houses

Home, Favorites, Bookings, Profile are four houses on the same street.

Each house has its own hallway.

If they shared one hallway, walking deep into Home’s hallway and then entering Profile’s front door would be confusing. You would still be holding Home’s papers.

So: **one stack per tab.**

Wrong version (do not do this):

```swift
NavigationStack {          // one hallway for the whole street
    TabView {
        Home()
        FavoritesView()
        ...
    }
}
```

Right version (what `HomeView` does):

```swift
TabView {
    NavigationStack { Home() }
    NavigationStack { FavoritesView() }
    NavigationStack { BookingsView() }
    NavigationStack { ProfileView() }
}
```

---

## `dismiss()` needs a parent

`@Environment(\.dismiss)` works when this screen was **presented** somehow:

- pushed by a `NavigationLink`
- shown as a sheet / fullScreenCover

If you open `SignupView` all by itself, with no parent, `dismiss()` has nowhere to go. That is why previews wrap destination screens like this:

```swift
#Preview {
    NavigationStack {
        SignupView()
    }
}
```

The preview gives Signup a fake desk so Back / dismiss can exist while you design.

In the real app, Onboarding’s stack is that desk. The preview stack is only for Xcode canvas.

---

## `CommonButton` in one sentence

`CommonButton` is a costume.

- Costume A: looks like a green bar, actually a `NavigationLink` (`isNavigation: true`)
- Costume B: looks like a green bar, actually a `Button` (`isNavigation: false`)

Use costume A only when the next screen is real and ready.

Use costume B when you are calling an API, validating a form, or the next screen is not built yet.

Passing `EmptyView()` as `destination` with `isNavigation: true` is how we accidentally teleported people into an empty room.

---

## Who owns a stack now? (cheat sheet)

| Screen | Owns a `NavigationStack`? | Why |
|---|---|---|
| `OnboardingScreens` | **Yes** | Root of the logged-out hallway |
| `LoginView` | No | A paper on Onboarding’s pile |
| `SignupView` | No | A paper on Onboarding’s pile |
| `ForgetPasswordView` | No | A paper on Onboarding’s pile |
| `OTPVerifyView` | No | A paper on Onboarding’s pile |
| `HomeView` (the tab bar) | No, but each tab does | The street, not a hallway |
| `Home` | No | First paper of the Home tab |
| `FavoritesView` | No | First paper of the Favorites tab |
| `BookingsView` | No | First paper of the Bookings tab |
| `ProfileView` | No | First paper of the Profile tab |
| `VendorsView` | No | Pushed from Home or Favorites |

If you add a new screen, ask: “Am I a new hallway, or a new room?”

- New hallway (rare): you own a stack.
- New room (usual): you do not.

---

## What still is not a navigation bug (so you do not panic)

These are unfinished product screens, not broken stacks:

- Profile rows (Payments, Notifications) look tappable but do not push yet. We did **not** turn them into empty `NavigationLink`s on purpose.
- Home bell, gear, and Book now are buttons with empty actions until those screens exist.
- Vendor detail is not built, so the card does not push.
- OTP Verify does not call an API yet. It just no longer pushes a blank page.
- Guest mode is still a `fullScreenCover` with placeholder text. A cover is a new card slapped on the desk. It is not the same as a stack paper. That is OK for a temporary guest screen.

When you build those screens, prefer:

```swift
NavigationLink {
    RealScreen()
} label: {
    ...
}
```

inside the stack that already exists. Do not add a new `NavigationStack` inside `RealScreen`.

---

## A tiny practice drill

Say these out loud when you write UI:

1. “Is this the first screen of a flow or a tab?” → maybe a stack.
2. “Did another screen already open me?” → no stack.
3. “Do I want to go forward?” → `NavigationLink` or `navigationDestination`.
4. “Do I want to go back to the screen that opened me?” → `dismiss()`.
5. “Did the user become a logged-in person?” → flip `isLoggedin`, do not push.
6. “Is the destination not built yet?” → `Button`, not a link.

If you only remember one line, remember this:

**One pile of papers per hallway. Screens are papers. Stacks are desks. Do not put desks on desks.**

---

## What we changed in the project (the grown-up checklist)

Use this when you open a pull request or when you forget what the diff was for.

### Auth

- `LoginView`: removed its inner `NavigationStack`. It is now only content. Onboarding’s stack is the parent.
- `SignupView`: removed its inner `NavigationStack`.
- `SignupView`: “Already have an account? Login” calls `dismiss()` instead of pushing a new `LoginView`.
- `OTPVerifyView`: Verify is a normal button, not a link to `EmptyView()`.
- Previews for Login, Signup, Forgot Password, OTP, Home, Vendors, Favorites, Bookings wrap a `NavigationStack` so canvas has a parent pile.

### Logged-in tabs

- `HomeView`: `TabView(selection:)` with tags `0...3`.
- Home “See all” favorites sets `selectedTab = 1` instead of pushing a blank (or duplicate) Favorites screen.
- Bookings tab shows `BookingsView`, not `FavoritesView`.
- Profile tab now has `.tag(3)` so selection works.

### Empty links → buttons

- Home bell, gear, Book now: `Button` until those screens exist.
- Vendor cards: not wrapped in an empty `NavigationLink`. Like stays a `Button`.

### New file

- `Views/Bookings/BookingsView.swift`
- This guide: `Docs/NavigationStack-Explained.md`

Onboarding, the per-tab stacks, `Main.swift`’s `isLoggedin` swap, Favorites → Vendors, and Home → Vendors were already the right shape. We left them alone on purpose.

# 들어가며

2023년 6월 6일, 블리자드는 디아블로 4를 공식 오픈했다. 디아블로 오픈 전, MacOS도 지원한다는 찌라시를 어디선가 듣고 설치하려 했으나, 역시나 MacOS를 지원하지 않았다. Macbook Pro 14 M2(RAM 16GB, SSD 1TB)를 구입한지 얼마 안 되어서 Windows PC를 구입하기에는 꽤나 부담스러운 취미가 될 것 같았다.

그러던 찰나에, 문득 `Macbook에서 Windows 프로그램을 실행시킬 수 있지 않나?`라는 물음표가 머릿속에 맴돌았다. 폭풍 구글링 후 약 12시간 정도 걸린 삽질 끝에 현재 맥북으로 디아블로 4를 실행할 수 있게 되었다. 오늘은 이 경험을 토대로 맥북에서 디아블로 4를 실행할 수 있는 방법에 대해서 기술하려고 한다.

> 설치 과정이 결코 간단하지는 않으니, 관심이 있다면 잘 따라오길 바란다. 다시 한 번 말하지만, 아래 과정 중 하나라도 스킵하지 말고 잘 따라오길 바란다. 무심코 지나쳤다가는 디아블로 4 성역에 입장하지 못하는 대신에 무한 삽질의 지옥에 빠질 수 있다.

# 1. 사전 설치

## 1.1. Game Porting Toolkit 설치

Apple은 2023년 6월 6일에 Windows용 게임을 실행할 수 있도록 해주는 Game Porting Toolkit(GPT)을 출시했다. 이를 통해, MacOS에서도 Windows 게임을 실행할 수 있다.

Apple Developer에서 dmg 파일을 다운로드 받을 수 있다. Apple Developer 사이트에 접속해서 Apple 계정으로 로그인 한 후, 아래 프로그램을 다운로드 받고 설치한다.

- Command Line Tools for Xcode 15 beta
- Apple game porting toolkit beta

> Xcode 15 beta는 MacOS 14 beta로 내장 설치되어 있다. 만약, 이전 버전의 Xcode가 설치되어 있다면 이전 버전의 Xcode, Command Line Tools for Xcode를 삭제 후 Xcode 15 beta로 설치해주어야 한다.

## 1.2. Battle.net 설치

[Windows용 Battle.net 데스크탑 애플리케이션](https://download.battle.net/en-gb/?platform=windows)을 설치 파일을 다운로드 받는다. 이 파일은 `~/Downloads` 폴더 안에 `Battle.net-Setup.exe`으로 다운로드 되어야 한다.

> 별다른 설정을 하지 않았다면 일반적으로 `~/Downloads/Battle.net-Setup.exe`으로 다운로드된다.

# 2. Rosetta 설정

현재 MacOS(ventura 13.4)에서는 Rosetta가 이미 설치되어 있는 듯하다. 만약, MacOS 버전이 최신이 아닌 탓에 Rosetta가 설치되어 있지 않거나, Rosetta를 설치하지 않았다면 터미널에 아래 명령어를 입력해서 Rosetta를 먼저 설치하도록 한다.

```zsh
$ softwareupdate --install-rosetta
```

`Finder`에서 `터미널(Terminal)`을 찾는다.

<div align='center'>
  <img width="747" alt="1" src="https://github.com/choewy/macos-diablo-4/assets/70950533/b4edc0c0-f9fa-4fc2-ba0e-f61a67f6c064">
</div>

터미널에 마우스 우클릭 한 후 `정보 가져오기`를 클릭한다. 그러면 아래 이미지와 같은 창이 뜨는데, `Rosetta를 사용하여 열기` 옵션을 찾아서 체크한 후 닫는다.

<div align='center'>
  <img width="325" alt="2" src="https://github.com/choewy/macos-diablo-4/assets/70950533/4e7d535c-4440-433b-a515-69b256c810fa">
</div>

# 3. Homebrew 설정

MacOS에서 Windows 프로그램을 실행해야 하므로 homebrew 또한 x86_64 버전으로 실행해야 한다.

> 일반적으로 M1, M2에서 설치한 homebrew는 ARM64 버전이다.

## 3.1. zsh 터미널 설정

Apple Gaming Toolkit Wiki 문서에 따르면, 이전에 ARM64 homebrew를 설치한 적이 있다면 ARM64 homebrew를 제거하는 편이 낫다고 한다. 그러나, 나는 이전에 설치한 hoembrew를 제거하지 않고, `.zshrc` 파일에 brew-switcer를 추가하여 두 버전 중 하나를 사용할 수 있도록 설정하였다. 터미널을 열고, 아래 명령어를 입력한다.

> bash를 사용하는 경우에는 ~/.bashrc를 수정하면 된다.

```zsh
$ vi ~/.zshrc
```

터미널이 텍스트 편집 모드로 변경되면, `i`를 눌러서 insert 모드로 변경한 후 아래 화살표 키를 눌러 커서를 맨 아래로 이동시킨다. 그리고 아래 스크립트를 붙여넣는다. `shift` + `;` 키를 누르고, `wq!`를 입력한 다음에 `Enter` 키를 눌러 스크립트를 저장한다.

```zsh
# ... 생략 ...

if [ "$(arch)" = "arm64" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    eval "$(/usr/local/bin/brew shellenv)"
fi
```

아래 명령어를 입력하여 x86_64 버전의 homebrew를 실행할 수 있도록 해주자.

> 앞으로 모든 과정은 이 터미널에서 진행하니, 터미널을 닫지 말고 계속 열어두자. 만약, 터미널을 닫았다면 아래 명령어를 먼저 입력하고 이어서 진행하기 바란다.
> 추가적으로 언어도 en_US.UTF-8로 설정해주어야 한다. 이 부분을 발견하지 못해서 약 4시간 가량 삽질을 했다. 맥북 언어가 이미 en_US.UTF-8로 되어 있는 경우 해당 명령어는 무시해도 상관 없겠지만, 그냥 아래 명령어 전체를 입력하기 바란다.

```zsh
$ arch -x86_64 zsh
$ LANG=en_US.UTF-8
```

## 3.2. Homebrew x86_64 설치

```zsh
$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

설치가 완료되었다면 아래 명령어를 입력해서 homebrew 실행 경로를 설정한다.

```zsh
$ (echo; echo 'eval "$(/usr/local/bin/brew shellenv)"') >> /Users/$USER/.zprofile
$ eval "$(/usr/local/bin/brew shellenv)"
```

아래 명령어를 입력해서 설정된 실행 경로를 확인한다.

```zsh
$ which brew
```

만약, `/usr/local/bin/brew`로 출력되지 않는다면 아래 명령어를 입력해서 실행 경로를 직접 설정한다.

```zsh
$ export PATH=/usr/local/bin:${PATH}
```

# 4. game-porting-toolkit 설정

## 4.1. Apple Homebrew tab 설치

터미널에서 game-porting-toolkit을 사용하기 위해서는 formula를 설치해야 한다. 이 과정에서 Apple Homebrew tab을 사용하므로, 아래 명령어를 입력하여 Apple Homebrew tab을 다운로드한다.

```zsh
$ brew tap apple/apple http://github.com/apple/homebrew-apple
```

## 4.2. game-porting-toolkit formula 설치

아래 명령어를 입력하여 game-porting-toolkit formula를 설치한다.

> 나는 와이파이로 설치했기 때문에 6시간 가량 소요되었던 것 같다. 그러니, 인내심을 갖고 바람 좀 쐬고 오기 바란다. 중간에 인터넷 연결이 끊기거나, 화면 잠금 상태로 전환되는 경우 다시 설치해야 할 수도 있으니, 설치를 한 번에 끝내고 싶다면 LAN 선을 연결하고, 자동 화면 잠금은 꺼두기 바란다.

```zsh
$ brew -v install apple/apple/game-porting-toolkit
```

문서에 따르면 설치 과정 중에 아래와 같은 오류가 발생할 수 있다고 한다.

> Error: game-porting-toolkit: unknown or unsupported macOS version: :dunno”, your version of Homebrew doesn’t have macOS Sonoma support. Update to the latest version of Homebrew and try again.

당황하지 말고, 아래 명령어를 입력하여 재설치하도록 하자.

```zsh
$ brew update brew -v install apple/apple/game-porting-toolkit
```

## 4.3. Game Porting Tookit 연결

아래 명령어를 입력하여 Game Porting Tookit DMG가 `/Volumes/Game Porting Toolkit-1.0`에 탑재되어 있는지 확인 후 Game Porting Tookit 라이브러리 폴더를 Wine의 라이브러리 폴더로 복사한다.

```zsh
$ ditto /Volumes/Game\ Porting\ Toolkit-1.0/lib/ `brew --prefix game-porting-toolkit`/lib/
```

아래 명령어를 입력하여 Game Porting Tookit DMG의 스크립트를 `/usr/local/bin`에 복사한다.

```zsh
$ cp /Volumes/Game\ Porting\ Toolkit*/gameportingtoolkit* /usr/local/bin
```

# 5. Wine 설정

Wine은 쉽게 말하자면 가상 Windows 운영 체제를 사용할 수 있도록 해주는 툴이라고 할 수 있다.

> Wine은 game-porting-toolkit folmula 설치 시 함께 설치된다.
> 여담이지만, Wine의 역할에 대한 이해를 돕기 위해 실제 나의 경험을 적어보았다. 맥북을 구매하기 전에는 노트북에 Ubuntu22.04를 설치해서 주 운영체제로 사용했다. 카카오톡이나, 아래 한글 등 Windows 프로그램은 Linux를 지원하지 않기 때문에 Ubuntu에서 Wine으로 Windows 프로그램을 실행하곤 했다.

우리는 MacOS에 디아블로 4 Windows 프로그램을 실행할 것이므로 Wine 설정을 해주어야 한다. 아래 명령어를 입력하면 Wine 설정 창이 뜨는데, 반드시 영어로 된 창이 떠야 한다.

> `WINEPREFIX=` 뒤에는 자신이 원하는 폴더 경로를 입력해도 되는데, 이 글에서는 `~/Games`로 할 것이므로 삽질할 시간을 줄이기 위해 가급적이면 `~/Games`로 통일하도록 하자.

```zsh
WINEPREFIX=~/Games `brew --prefix game-porting-toolkit`/bin/wine64 winecfg
```

아래 이미지에서 보이는것 처럼 `Windows Version`를 `Windows 10`으로 선택 후 `apply`와 `Ok`을 클릭하여 설정 창을 닫아준다.

<div align='center'>
  <img width="406" alt="3" src="https://github.com/choewy/macos-diablo-4/assets/70950533/0ca17acc-810e-4b18-abff-5dcf1e2f5034">
</div>

문서에 따르면 디아블로 4를 실행하려는 경우 아래 스크립트를 실행하여 최신 버전의 Windows로 나타나도록 Wine 접두사를 수정해야 한다고 되어있으니, 아래 명령어를 실행해주도록 한다.

```zsh
$ WINEPREFIX=~/Games `brew --prefix game-porting-toolkit`/bin/wine64 reg add 'HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion' /v CurrentBuild /t REG_SZ /d 19042 /f
$ WINEPREFIX=~/Games `brew --prefix game-porting-toolkit`/bin/wine64 reg add 'HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion' /v CurrentBuildNumber /t REG_SZ /d 19042 /f
$ WINEPREFIX=~/Games `brew --prefix game-porting-toolkit`/bin/wineserver -k
```

# 6. Battle.net 설치 및 실행

아래 명령어를 입력해서 Wine으로 `Battle.net-Setup.exe`를 실행하여 배틀넷을 설치하도록 하자.

> 이때, 언어는 `English(US)`로 하는 것을 권장한다. 한국어로 설치하는 경우 Wine에서 한글을 인코딩할 수 있도록 별도로 설정해주어야 하기 때문이다. 디아블로 4를 설치할 때에는 한국어로 설정할 수 있으니 걱정하지 말고, 배틀넷만 영어로 설치하기 바란다.

```zsh
$ gameportingtoolkit ~/Games ~/Downloads/Battle.net-Setup.exe
```

설치가 완료되면 Battle.net이 실행되니, 자동 로그인 설정을 체크하고 로그인하여 디아블로 4를 설치하면 된다.

# 7. 실행 스크립트

맥북을 재부팅 후, Windows용 Battle.net 및 디아블로 4를 실행하려면 터미널에 아래 스크립트를 입력하면 된다.

> shell script 파일은 [Github](https://github.com/choewy/macos-diablo-4)에 올려놓았다.

## 7.1. Battle.net 실행 스크립트

```zsh
LANG=en_US.UTF-8
arch -x86_64 gameportingtoolkit-no-hud ~/Games 'C:\Program Files (x86)\Battle.net\Battle.net Launcher.exe'
```

## 7.2. 디아블로 4 실행 스크립트

```zsh
LANG=en_US.UTF-8
arch -x86_64 gameportingtoolkit-no-hud ~/Games 'C:\Program Files (x86)\Battle.net\Battle.net Launcher.exe'
```

### 7.3 Application 등록 Automator - 셸 스크립트 실행 - 코드 입력 - 응용프로그램에 `Diablo IV` 저장
```zsh
#!/bin/zsh

export PATH="/usr/local/bin:${PATH}"
LANG=en_US.UTF-8
arch -x86_64 gameportingtoolkit-no-hud ~/Games 'C:\Program Files (x86)\Battle.net\Battle.net Launcher.exe'

LANG=en_US.UTF-8
arch -x86_64 gameportingtoolkit-no-hud ~/Games 'C:\Program Files (x86)\Battle.net\Battle.net Launcher.exe'
```


# 마치며

맥북에서 디아블로 4가 처음 실행되는 것을 확인했을 당시에는 디아블로 4 전설 아이템을 획득할 때보다 훨씬 짜릿했다. 한가지 단점이 있다면, 맥북으로 디아블로를 실행하면 맥북의 발열이 심해진다는 것이다. 디아블로 디스플레이 옵션을 `낮음`으로 설정해놓고, 프레임을 80으로 고정해놓고 플레이해도 표면 온도 40도 정도를 유지하는 것 같다. 역시 맥북이라 그런지는 몰라도, 디스플레이 옵션을 `낮음`으로 해놓고 플레이해도 매우 우수한 화질로 게임을 플레이할 수 있다. 내 본업(개발자)을 위해 구매한 맥북으로 디아블로 4를 플레이할 줄이야... 며칠만 즐기다가 다시 코딩해야겠다.

# 참고자료

- [Apple Gamning Wiki - Game Porting Toolkit](https://www.applegamingwiki.com/wiki/Game_Porting_Toolkit)
- [How to install game-porting-toolkit](https://gist.github.com/Frityet/448a945690bd7c8cff5fef49daae858e)
- [Playing Diablo IV on macOS](https://www.outcoldman.com/en/archive/2023/06/07/playing-diablo-4-on-macos)
- [YouTube : Diablo 4 Works on Mac, This is How (Instructions, FPS test)](https://www.youtube.com/watch?v=5Nd-nR3-6lU&t=492s)

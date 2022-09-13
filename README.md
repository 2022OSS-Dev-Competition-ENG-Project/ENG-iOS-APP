# <img width=25px src=https://user-images.githubusercontent.com/77708819/189899360-aa5aec87-49a4-4878-8ea1-16596834a453.png> ENG-iOS-APP

> **2022년 공개 SW 개발자대회** <br>
> **프로젝트 기간 : 2022.07 ~**
>
> **안전불감증 솔루션**
> **(SwiftUI)**

## 🥕 주요 서비스
> **ENG** 서비스의 시설물 이용자를 위한 애플리케이션
1. 서비스 이용을 위한 회원 서비스를 제공합니다.
2. 사용자는 시설물을 이용하기 위해 시설물을 등록하고, 등록된 시설물을 관리할 수 있습니다.
3. 시설물 관리자가 제공하는 안전 정보를 제공받을 수 있습니다.
4. 안전소통게시판을 통해 시설 이용자간 소통할 수 있습니다.
5. 이미지를 통한 위험 요소에 대한 분석 서비스를 제공받을 수 있습니다.

## 🗂 프로젝트 폴더 구조
```
📦 ENG
│
+ 🗂 Network
│
+ 🗂 Font
│
+ 🗂 Extension
│
+ 🗂 ViewModels
│         └── 🗂 AccountViewModels
│         └── 🗂 FacilityViewModels
│         └── 🗂 MyProfileViewModels
│         └── 🗂 PostingViewModels
│         └── 🗂 ReportViewModels
│         └── 🗂 RiskAnalysisViewModels
│
+ 🗂 Models
│         └── 🗂 AccountModels
│         └── 🗂 FacilityModels
│         └── 🗂 MyProfileModels
│         └── 🗂 PostingModels
│         └── 🗂 ReportModels
│ 
+ 🗂 Views
│         └── 🗂 AccountViews
│         └── 🗂 CoreViews
│         └── 🗂 FacilityViews
│         └── 🗂 MyProfileViews
│         └── 🗂 PostingViews
│         └── 🗂 ReportViews
│         └── 🗂 RiskAnalysisViews
│         └── 🗂 ViewComponents
```

## 👓 설치
### clone repository
```
$ git clone https://github.com/2022OSS-Dev-Competition-ENG-Project/ENG-iOS-APP.git
$ cd ENG-iOS-APP
$ open ENG.xcodeproj
```

## 🪖 프로젝트 초기 설정
1. XCode로 ENG 프로젝트 오픈
2. Network Group(Folder) 오픈
3. NetworkResources 파일 오픈
4. NetworkManager Class의 IP 정보 수정
```swift
/// 시설 관련 API 서버 IP
let facilityIp: String = "http://127.0.0.1:2200"
/// 유저 관련 API 서버 IP
let userIp: String = "http://127.0.0.1:2201"
/// AI 관련 API 서버 IP
let AIIp: String = "http://127.0.0.1:2222"
```

## 📱 UI Image
<details>
<summary>회원서비스</summary>
<img src=https://user-images.githubusercontent.com/77708819/189688299-e9b09681-0111-4f19-a6eb-86f989e47555.png>
<img src=https://user-images.githubusercontent.com/77708819/189688463-434763a1-6a46-44b5-9fb5-15ccd55a0faf.png>
<img src=https://user-images.githubusercontent.com/77708819/189688476-dfd7fe4b-06c8-475d-85ee-050408ff601c.png>
</details>

<details>
<summary>시설 서비스</summary>
<img src=https://user-images.githubusercontent.com/77708819/189688496-9d25f101-b775-4bda-a34b-b7625fb04e6a.png>
<img src=https://user-images.githubusercontent.com/77708819/189688502-b664ddcd-e043-44d0-826b-a059c7c08124.png>
</details>

<details>
<summary>신고하기</summary>
<img src=https://user-images.githubusercontent.com/77708819/189688518-680ccd48-6a2c-4e89-b975-552ab1df1c03.png>
</details>

<details>
<summary>위험 분석</summary>
<img src=https://user-images.githubusercontent.com/77708819/189688532-3779eb43-5c62-4cba-99b0-8eee2e9ca157.png>
</details>

<details>
<summary>마이 페이지</summary>
<img src=https://user-images.githubusercontent.com/77708819/189688543-4b79401f-3756-4961-8065-a3fb7d572227.png>
</details>

## 💻 개발/배포 환경
XCode Version 13.4.1
iOS 15이상

``` 
클라이언트 개발 플랫폼 : iOS
클라이언트 개발 환경 : XCode
클라이언트 개발 언어 : Swift 5
클라이언트 개발 프레임워크 : SwiftUI
사용한 Swift 디자인패턴 : MVVM
```

## 😎 개발자
- 정승균 [seunggyun-jeong](https://github.com/seunggyun-jeong) : ENG Project iOS 앱 클라이언트 개발
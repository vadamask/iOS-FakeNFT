#   Требования

##  Ссылки
        - [Ссылка на репозиторий](https://github.com/CodeByViktor/iOS-FakeNFT)
        - [Критерии ревью](https://code.s3.yandex.net/Mobile/iOS/pdf/New_Все_критерии.pdf?etag=f11d4427af3a19fc4c852184015ae09d)
        - [Работа над проектом (с курса)](https://practicum.yandex.ru/learn/ios-developer/courses/33ed0352-ca53-4b0e-ab40-bd284ce09db6/sprints/161274/topics/41e8b28b-a31f-4461-8418-df0d3949590c/lessons/e53e27ab-525d-4e08-9eed-19263f2db7f2/)
        - [Workflow (с курса)](https://practicum.yandex.ru/learn/ios-developer/courses/33ed0352-ca53-4b0e-ab40-bd284ce09db6/sprints/161274/topics/4c10cfc0-609a-441f-a756-c79df5f585f7/lessons/1d61708e-5f5e-4159-ac87-7a29050528cf/)
        - [Полезная статья (git & team)](https://ruseller.com/lessons.php?rub=28&id=2207)
        
##  Требования
        - Архитектура - MVVM (combine, native)
        - Верстка кодом (SnapKit)
        - Min iOS 13.0
        - Поддержка SE ?
        - SwiftLint
        - Swiftgen (можно аналог)

##  Примерное workflow (major.minor.patch)
        1. Pull develop
        2. new feature (branch) from develop
        3. pull develop
        4. resolve conflicts (if needed)
        5. PR merge feature to develop
        6. resolve conflicts (if needed)
        7. PR merge develop to main(master)
        8. main(master) merge to develop

# ng_admin

Admin Template based on Angular Dart. It consists of common directives, components, as well as javascript interops that save your time drastically when it comes to building an Admin based website.

## Getting Started

  * Create a new Angular Dart project. Refer to this [docs](https://angulardart.dev/guide/setup) for more details.
  * Grab [Tachyon css](https://unpkg.com/tachyons@4/css/tachyons.min.css) and [Material icons](https://fonts.googleapis.com/icon?family=Material+Icons) from any of CDN providers out there, place them in the <head> of web/index.html as well as another necessary dependencies. You might want to copy over our [demo index.html](https://github.com/wowsomeco/ng_dart_admin/blob/master/example/web/index.html) for starters.   
  * Add [ngadmin](https://pub.dev/packages/ng_admin) to your package's pubspec.yaml file :

  ``` yaml
  dependencies:
    ng_admin: ^<latest_version>
  ```

  * Profit! :)

## Why Dart for web

  * It's been a love-hate relationship to me personally with javascript. As much as I love how flexible the language is, it hits me hard in the face when it comes to working on the bigger scale projects that involves working with more than 2 developers. Sometimes programmers (me included) tend to make bugs that are very hard to trace in the javascript environment. We often find it very hard to understand each other's code since variables can have any type. Most of the time whenever there are complex code produced by the others, it feels like a here's-the-riddle-for-you-find-the-answer thingy for the rest. That's when I thought perhaps we should consider working on another language that is statically typed to save our lives from the madness. I think Dart really shines in this area, not to mention how familiar the language is from the get-go, seems like we already know this language for years already even though we just recently started. The dependencies on another package is very minimal too as the language itself comes with rich built-in libraries already (batteries included). Once we convert, we (I) dont want to look back :)

  * Interop with javascript easily. That's one of the reasons this package exists! you'll find more js interops eventually for sure.

  * It makes it easier for us to reuse business logic across platform (Web and Mobile). As much as I can't wait for Flutter to be available for web, IMO it's not ready yet for now. The strategy for us currently is to utilize both Angular Dart for web as well as Flutter for mobile and try to reuse as much platform agnostic logic as possible in one package that is shared for both of them.

## Why not Dart for web

  Of course Dart is not a silver bullet for all edge cases. Sometimes you might want to stick with npm-js combo as they come with set of utilities that are not available in Dart environment just yet e.g. purge css, static site generator, etc. Rule of thumb for me is use npm for building company profile websites that need to be SEOed and loaded faster, and Dart for the rest.

## Why Tachyon CSS

  Atomic CSS is very powerful (debatable of course) and I've been utilizing it for a year, I'm by no means an expert in CSS and I feel that it helps me a lot when it comes to building complex components. Personally I prefer using [Tailwind](https://tailwindcss.com/) as it comes with more utilities and all that (FYI, I've been using it for making numerous company profile websites (combined with Gatsby js) and I can reduce the development time by miles, you should try it too!). Unfortunately the CDN build is very large and there's no way for us to purge it like how we could in the common npm project. that's where Tachyon shines as the CDN build is less than 100kb which is completely acceptable. It pretty much can do whatever Tailwind can and comes with better docs for use cases vs Tailwind IMO.

## Limitations

Use at your own risk! Please expect some bugs (and breaking changes too) here and there as it's meant to be used internally and still very much WIP for now. There are no unit tests coverage, very limited docs, etc. Currently I'm still busy working on some client projects that depends on this package. I will for sure provide those eventually :) Feel free to report bugs, submit feature requests, etc. on our github repo.


---
created: 2026-08-06T05:32:21.597Z
---

# Generate icons

Place icons in apps/app/assets/icons and name them `icon_prod.png` and `icon_staging.png`
Run file assets/icons/icon_prod.png to make sure they are square size
Run `melos run generate:icons`

If needed crop the image (make sure it doesn't have white around it too)
```sh
magick assets/icons/icon_prod.png \                        
  -gravity center -crop 768x768+0+0 +repage \
  -resize 1024x1024 \
  assets/icons/icon_staging_square.png
  ```

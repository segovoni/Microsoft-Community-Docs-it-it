---
# Sample for CSI
# required metadata

title: Metadata - OPS User Manual
description: This is to introduce metadata mechanism and rules in OPS.
keywords: metadata, user manual
author: sharriexie
manager: yegu
ms.date: 03/21/2016
ms.topic: get-started-article
ms.prod: azure
ms.service: storage
ms.assetid: 9e1d63fe-d71b-446c-88cc-812afc821cc0

# optional metadata

#ROBOTS: 
#audience:
#ms.devlang: 
ms.reviewer: sudeepku
ms.suite: ems
#ms.tgt_pltfrm:
#ms.technology:
#ms.custom:


---

# Metadata #

There is a limited amount of metadata at the moment. 

Metadata can be specified at two places: at topic level and docset level

## 1. Topic-level metadata

In each topic, you can use YAML header to store metadata in Markdown file. It will be transformed to `yamlheader` tag when processed.

This format is already widely used in Github and will be rendered into a table in Github Markdown preview. 

Yaml header MUST be the first thing in the MD file and MUST take the form of valid YAML set between triple-dashed lines. 

* All metadata labels should be in lower case.

Here are some examples:

```
---

title: Get Started

redirect_url: https://msdn.microsoft.com/virtualization/windowscontainers/

---
```

### Details of some topic-level metadata

| Metadata Name | Usage | Value Format | Default | IsOptional | Sample |
| --- |:---|---|:---|---|---|
| title | User can write this to overwrite the title in the navigation bar of that page. | string | It will extract the h1 as value. | Yes |title: page title|
| author | User can use this value to indicate the author of the topic. Set this value to override the default identified author. Should be the user name of Git account. | string | The default identified author is the committer of the first commit of the topic. | Yes |author: &lt;git account&gt;|
| update_date | User can specify the time of topic updated. | DateTime | Time of last commit. | Yes | update_date: 2/23/2016 |
| redirect_url | User can specify the value to indicate the topic to redirect to some other url. See [redirection page](OPredirection.md) for more detail. | string | null | Yes |redirect_url: https://msdn.microsoft.com |


### 1.1 Keep your metadata in a separated file

In case you don't want all your file level metadata to be stored in the markdown file, OPS provides another flexibility for you to maintain them in a separated file. You can use the [docfx.json](build-configuration.md) file within the same docset to achieve that.

Here's how it works
```
"fileMetadata": {
  "<metadata_name>": {
    "<file_name>": <value>
    …
  },
  …
}
```

You can see an example as below, file name here supports glob pattern (wildcard).
```
    "fileMetadata": {
      "priority": {
        "obj/docfx/**": 1.0,
        "**.md": 2.5,
        "spec/**.md": 3,
        "tutorial/**.md": 1.2
      },
      "keywords": {
        "obj/docfx/**": ["API", "Reference"],
        "spec/**.md": ["Spec", "Conceptual"],
        "**/*markdown.md": ["DFM", "Spec"]
      }
    },
```

## 2. Docset-level metadata

* Stored in [docfx.json](build-configuration.md) file within a docset.

- "robots": "NOINDEX, NOFOLLOW" - Indicates the search engines if the docset should be indexed by search engines.

### 2.1 API Scan
Seee [API Scan](APIScan.md).


{:user {:repositories {"my.datomic.com" {:url "https://my.datomic.com/repo"
                                         :username ""
                                         :password ""}}
        :plugins [[venantius/ultra "0.4.1"]
                  [com.jakemccrary/lein-test-refresh "0.14.0"]
                  [debugger "0.1.7" :exclusions [org.clojure/clojure]]
                  [lein-ancient "0.6.8"]
                  [lein-typed "0.3.5"]
                  [org.clojure/core.typed "0.3.23"]
                  [jonase/eastwood "0.2.1" :exclusions [org.clojure/clojure]]
                  [jonase/kibit "0.1.2" :exclusions [org.clojure/clojure]]]
        :dependencies [[alembic "0.3.2"]
                       [acyclic/squiggly-clojure "0.1.3-SNAPSHOT"] ^:replace [org.clojure/tools.nrepl "0.2.12"]]}
 :repl {:plugins [[cider/cider-nrepl "0.10.0-SNAPSHOT"]
                  [refactor-nrepl "2.0.0-SNAPSHOT"]]
        :dependencies [[org.clojure/tools.nrepl "0.2.12"]]}}


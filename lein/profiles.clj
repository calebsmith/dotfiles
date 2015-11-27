{:user {:repositories {"my.datomic.com" {:url "https://my.datomic.com/repo"
                                         :username ""
                                         :password ""}}}
 :plugins [
           [mvxcvi/whidbey "1.0.0" :exclusions [org.clojure/clojure]]
           [lein-kibit "0.1.2" :exclusions [org.clojure/clojure]]
           [lein-pprint "1.1.1"]
           [lein-deps-tree "0.1.2" :exclusions [org.codehaus.plexus/plexus-utils]]
           [lein-bin "0.3.5" :exclusions [org.clojure/clojure]]
           [debugger "0.1.7" :exclusions [org.clojure/clojure]]
           [jonase/eastwood "0.2.1" :exclusions [org.clojure/clojure]]
           [jonase/kibit "0.1.2" :exclusions [org.clojure/clojure]]]
 :dependencies [[alembic "0.3.2"]
                [[acyclic/squiggly-clojure "0.1.3-SNAPSHOT"]
                 ^:replace [org.clojure/tools.nrepl "0.2.12"]]]
 :repl {:plugins [[cider/cider-nrepl "0.10.0-SNAPSHOT"]
                  [refactor-nrepl "2.0.0-SNAPSHOT"]]
        :dependencies [[org.clojure/tools.nrepl "0.2.12"]]}}

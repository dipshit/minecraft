workflow "CI" {
  on = "push"
}

action "dipshit/kubeval" {
  uses = "docker://garethr/kubeval"
  args = "k8s/*"
}

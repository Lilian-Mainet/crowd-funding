;; Decentralized Crowdfunding Platform

;; Constants
(define-constant contract-owner tx-sender)
(define-constant err-owner-only (err u100))
(define-constant err-not-found (err u101))
(define-constant err-already-exists (err u102))
(define-constant err-invalid-amount (err u103))
(define-constant err-deadline-passed (err u104))
(define-constant err-goal-not-reached (err u105))
(define-constant err-already-claimed (err u106))
(define-constant  err-transfer-failed (err u107))

;; Data Maps
(define-map campaigns
  { campaign-id: uint }
  {
    owner: principal,
    goal: uint,
    raised: uint,
    deadline: uint,
    claimed: bool
  }
)

(define-map contributions
  { campaign-id: uint, contributor: principal }
  { amount: uint }
)

(define-map campaign-descriptions
  { campaign-id: uint }
  { description: (string-utf8 500) })


;; Variables
(define-data-var campaign-nonce uint u0)

;; Private Functions
(define-private (is-owner)
  (is-eq tx-sender contract-owner))

(define-private (current-time)
  (unwrap-panic (get-block-info? time u0)))

;; Read-only Functions
(define-read-only (get-campaign-details (campaign-id uint))
  (map-get? campaigns { campaign-id: campaign-id }))

(define-read-only (get-contribution (campaign-id uint) (contributor principal))
  (map-get? contributions { campaign-id: campaign-id, contributor: contributor }))
